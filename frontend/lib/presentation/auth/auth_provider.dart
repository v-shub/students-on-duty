import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api_client.dart';
import 'package:frontend/data/services/token_storage.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState({required this.status, this.user, this.errorMessage});

  AuthState.initial()
    : status = AuthStatus.initial,
      user = null,
      errorMessage = null;

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState.initial()) {
    _checkCurrentUser();
  }

  ApiClient get _apiClient => ref.read(apiClientProvider);
  TokenStorage get _tokenStorage => ref.read(tokenStorageProvider);

  Future<void> _checkCurrentUser() async {
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }

    state = state.copyWith(status: AuthStatus.loading);
    try {
      final user = await _apiClient.getCurrentUser();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      await _tokenStorage.clearTokens();
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _parseError(e),
      );
    }
  }

  String _parseError(Object error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        try {
          // Пытаемся извлечь сообщение из стандартного поля "message"
          final data = error.response?.data;
          if (data is Map && data.containsKey('message')) {
            return data['message'].toString();
          }
        } catch (_) {}
      }
      return 'Ошибка соединения: ${error.message}';
    }
    return error.toString();
  }

  // В классе AuthNotifier

  Future<bool> requestCode({String? email, String? phone}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final response = await _apiClient.requestCode(email: email, phone: phone);
      // Даже если пользователь уже существует, мы продолжаем (для входа)
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _parseError(e),
      );
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? phone,
    required String code,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final authResponse = await _apiClient.login(
        email: email,
        phone: phone,
        code: code,
      );
      await _tokenStorage.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      final user = await _apiClient.getCurrentUser();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _parseError(e),
      );
      return false;
    }
  }

  Future<bool> register({
    required String code,
    required String username,
    required String password,
    String? email,
    String? phone,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final authResponse = await _apiClient.register(
        code: code,
        username: username,
        password: password,
        email: email,
        phone: phone,
      );
      await _tokenStorage.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      final user = await _apiClient.getCurrentUser();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _parseError(e),
      );
      return false;
    }
  }

  Future<void> logout() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _apiClient.logout(refreshToken);
      } catch (e) {
        // ignore
      }
    }
    await _tokenStorage.clearTokens();
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
