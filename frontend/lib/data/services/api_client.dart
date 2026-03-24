import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/data/models/absence.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/duty_type.dart';
import 'package:frontend/data/models/group.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:frontend/data/models/dto/create_absence_dto.dart';
import 'package:frontend/data/models/dto/update_absence_dto.dart';
import 'package:frontend/data/models/dto/create_duty_type_dto.dart';
import 'package:frontend/data/models/dto/update_duty_type_dto.dart';
import 'package:frontend/data/models/dto/create_duty_schedule_dto.dart';
import 'package:frontend/data/models/dto/update_duty_schedule_dto.dart';
import 'package:frontend/data/models/dto/create_duty_day_dto.dart';
import 'package:frontend/data/models/dto/update_duty_day_dto.dart';

part 'api_client.g.dart';
part 'api_client.freezed.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return ApiClient(tokenStorage);
}

class ApiClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  // Для Android эмулятора используйте 10.0.2.2
  static const String baseUrl = 'http://localhost:3000';
  // Для iOS симулятора: 'http://localhost:3000'

  ApiClient(this._tokenStorage)
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    // Логгер для отладки
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: _onRequest, onError: _onError),
    );
    // Retry-интерцептор: повторяет запрос при разрыве соединения с облачной БД
    _dio.interceptors.add(_RetryInterceptor(_dio));
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null && !_isPublicEndpoint(options.path)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  bool _isPublicEndpoint(String path) {
    return path.startsWith('/users/request-code') ||
        path.startsWith('/users/register') ||
        path.startsWith('/users/login') ||
        path.startsWith('/users/refresh');
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _tokenStorage.getRefreshToken();
        if (refreshToken != null) {
          final newTokens = await _refreshAccessToken(refreshToken);
          await _tokenStorage.saveTokens(
            newTokens.accessToken,
            newTokens.refreshToken,
          );

          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
          final response = await _dio.fetch(opts);
          return handler.resolve(response);
        }
      } catch (e) {
        await _tokenStorage.clearTokens();
      }
    }
    handler.next(err);
  }

  Future<RefreshResponse> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/users/refresh',
        data: {'refreshToken': refreshToken},
      );
      return RefreshResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to refresh token');
    }
  }

  // ==================== АУТЕНТИФИКАЦИЯ ====================
  
  Future<RequestCodeResponse> requestCode({
    String? email,
    String? phone,
  }) async {
    try {
      final response = await _dio.post(
        '/users/request-code',
        data: {
          if (email != null && email.isNotEmpty) 'email': email,
          if (phone != null && phone.isNotEmpty) 'phone': phone,
        },
      );
      return RequestCodeResponse(
        success: true,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return RequestCodeResponse(
          success: true,
          alreadyExists: true,
          message: e.response?.data['message'] ?? 'Код отправлен',
        );
      }
      rethrow;
    }
  }

  Future<AuthResponse> register({
    required String code,
    required String username,
    required String password,
    String? email,
    String? phone,
  }) async {
    final response = await _dio.post(
      '/users/register',
      data: {
        'code': code,
        'username': username,
        'password': password,
        if (email != null && email.isNotEmpty) 'email': email,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginWithCode({
    String? email,
    String? phone,
    required String code,
  }) async {
    final response = await _dio.post(
      '/users/login/code',
      data: {
        if (email != null && email.isNotEmpty) 'email': email,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        'code': code,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginWithPassword({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      '/users/login/password',
      data: {
        'username': username,
        'password': password,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  @Deprecated('Use loginWithCode or loginWithPassword instead')
  Future<AuthResponse> login({
    String? email,
    String? phone,
    required String code,
  }) async {
    return loginWithCode(email: email, phone: phone, code: code);
  }

  Future<User> getCurrentUser() async {
    final response = await _dio.get('/users/me');
    return User.fromJson(response.data);
  }

  Future<User> updateUser({
    String? email,
    String? phone,
    String? password,
  }) async {
    final response = await _dio.put(
      '/users/me',
      data: {
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (password != null) 'password': password,
      },
    );
    return User.fromJson(response.data);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post('/users/logout', data: {'refreshToken': refreshToken});
    await _tokenStorage.clearTokens();
  }

  // ==================== ГРУППЫ ====================
  
  Future<Group> createGroup(String name, {String? description}) async {
    final response = await _dio.post(
      '/groups',
      data: {'name': name, 'description': description},
    );
    return Group.fromJson(response.data);
  }

  Future<List<Group>> getGroups() async {
    final response = await _dio.get('/groups');
    return (response.data as List).map((json) => Group.fromJson(json)).toList();
  }

  Future<Group> getGroup(int id) async {
    final response = await _dio.get('/groups/$id');
    return Group.fromJson(response.data);
  }

  Future<Group> updateGroup(int id, {String? name, String? description}) async {
    final response = await _dio.put(
      '/groups/$id',
      data: {'name': name, 'description': description},
    );
    return Group.fromJson(response.data);
  }

  Future<void> deleteGroup(int id) async {
    await _dio.delete('/groups/$id');
  }

  // ==================== СТУДЕНТЫ ====================
  
  Future<Student> createStudent(
    String name, {
    required int groupId,
    bool isActive = true,
  }) async {
    final response = await _dio.post(
      '/students',
      data: {'name': name, 'group_id': groupId, 'is_active': isActive},
    );
    return Student.fromJson(response.data);
  }

  Future<List<Student>> getStudents() async {
    final response = await _dio.get('/students');
    return (response.data as List)
        .map((json) => Student.fromJson(json))
        .toList();
  }

  Future<Student> getStudent(int id) async {
    final response = await _dio.get('/students/$id');
    return Student.fromJson(response.data);
  }

  Future<Student> updateStudent(int id, {String? name, bool? isActive}) async {
    final response = await _dio.put(
      '/students/$id',
      data: {'name': name, 'is_active': isActive},
    );
    return Student.fromJson(response.data);
  }

  Future<void> deleteStudent(int id) async {
    await _dio.delete('/students/$id');
  }

  // ==================== ОТСУТСТВИЯ ====================
  
  Future<Absence> createAbsence(CreateAbsenceDto dto) async {
    final response = await _dio.post('/absences', data: dto.toJson());
    return Absence.fromJson(response.data);
  }

  Future<List<Absence>> getAbsences({int? studentId}) async {
    final response = await _dio.get(
      '/absences',
      queryParameters: studentId != null ? {'student_id': studentId} : null,
    );
    return (response.data as List)
        .map((json) => Absence.fromJson(json))
        .toList();
  }

  Future<Absence> getAbsence(int id) async {
    final response = await _dio.get('/absences/$id');
    return Absence.fromJson(response.data);
  }

  Future<Absence> updateAbsence(int id, UpdateAbsenceDto dto) async {
    final response = await _dio.put('/absences/$id', data: dto.toJson());
    return Absence.fromJson(response.data);
  }

  Future<void> deleteAbsence(int id) async {
    await _dio.delete('/absences/$id');
  }

  // ==================== ТИПЫ ДЕЖУРСТВ ====================
  
  Future<DutyType> createDutyType(CreateDutyTypeDto dto) async {
    final response = await _dio.post('/duty-types', data: dto.toJson());
    return DutyType.fromJson(response.data);
  }

  Future<List<DutyType>> getDutyTypes() async {
    final response = await _dio.get('/duty-types');
    return (response.data as List)
        .map((json) => DutyType.fromJson(json))
        .toList();
  }

  Future<DutyType> getDutyType(int id) async {
    final response = await _dio.get('/duty-types/$id');
    return DutyType.fromJson(response.data);
  }

  Future<DutyType> updateDutyType(int id, UpdateDutyTypeDto dto) async {
    final response = await _dio.put('/duty-types/$id', data: dto.toJson());
    return DutyType.fromJson(response.data);
  }

  Future<void> deleteDutyType(int id) async {
    await _dio.delete('/duty-types/$id');
  }

  // ==================== РАСПИСАНИЯ ====================
  
  Future<DutySchedule> createDutySchedule(CreateDutyScheduleDto dto) async {
    final response = await _dio.post('/duty-schedules', data: dto.toJson());
    return DutySchedule.fromJson(response.data);
  }

  Future<List<DutySchedule>> getDutySchedules() async {
    final response = await _dio.get('/duty-schedules');
    return (response.data as List)
        .map((json) => DutySchedule.fromJson(json))
        .toList();
  }

  Future<DutySchedule> getDutySchedule(int id) async {
    final response = await _dio.get('/duty-schedules/$id');
    return DutySchedule.fromJson(response.data);
  }

  Future<DutySchedule> updateDutySchedule(
    int id,
    UpdateDutyScheduleDto dto,
  ) async {
    final response = await _dio.put('/duty-schedules/$id', data: dto.toJson());
    return DutySchedule.fromJson(response.data);
  }

  Future<void> deleteDutySchedule(int id) async {
    await _dio.delete('/duty-schedules/$id');
  }

  // ==================== ДНИ ДЕЖУРСТВ ====================
  
  Future<DutyDay> createDutyDay(CreateDutyDayDto dto) async {
    final response = await _dio.post('/duty-days', data: dto.toJson());
    return DutyDay.fromJson(response.data);
  }

  Future<List<DutyDay>> getDutyDays({
    int? scheduleId,
    bool? isMonday,
    bool? isTuesday,
    bool? isWednesday,
    bool? isThursday,
    bool? isFriday,
    bool? isSaturday,
    bool? isSunday,
  }) async {
    final query = <String, dynamic>{};
    if (scheduleId != null) query['schedule_id'] = scheduleId;
    if (isMonday != null) query['is_monday'] = isMonday;
    if (isTuesday != null) query['is_tuesday'] = isTuesday;
    if (isWednesday != null) query['is_wednesday'] = isWednesday;
    if (isThursday != null) query['is_thursday'] = isThursday;
    if (isFriday != null) query['is_friday'] = isFriday;
    if (isSaturday != null) query['is_saturday'] = isSaturday;
    if (isSunday != null) query['is_sunday'] = isSunday;

    final response = await _dio.get('/duty-days', queryParameters: query);
    return (response.data as List)
        .map((json) => DutyDay.fromJson(json))
        .toList();
  }

  Future<DutyDay> getDutyDaysBySchedule(int scheduleId) async {
    final response = await _dio.get('/duty-days/$scheduleId');
    return DutyDay.fromJson(response.data);
  }

  Future<DutyDay> updateDutyDay(int scheduleId, UpdateDutyDayDto dto) async {
    final response = await _dio.put(
      '/duty-days/$scheduleId',
      data: dto.toJson(),
    );
    return DutyDay.fromJson(response.data);
  }

  Future<void> deleteDutyDay(int scheduleId) async {
    await _dio.delete('/duty-days/$scheduleId');
  }

  // ==================== СОБЫТИЯ ====================
  
  Future<List<DutyEvent>> generateDutyEvents(
    int scheduleId,
    DateTime date,
  ) async {
    print('=== ApiClient.generateDutyEvents() ===');
    print('Schedule ID: $scheduleId');
    print('Date: ${date.toIso8601String().split('T').first}');
    
    try {
      final response = await _dio.post(
        '/duty-events/generate',
        data: {
          'schedule_id': scheduleId,
          'date': date.toIso8601String().split('T').first,
        },
      );
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      final events = (response.data as List)
          .map((json) => DutyEvent.fromJson(json))
          .toList();
      
      print('Parsed ${events.length} events');
      return events;
    } catch (e) {
      print('Error in generateDutyEvents: $e');
      rethrow;
    }
  }

  Future<List<DutyEvent>> getDutyEvents({int? scheduleId}) async {
    print('=== ApiClient.getDutyEvents() ===');
    print('Schedule ID filter: $scheduleId');
    
    try {
      final response = await _dio.get(
        '/duty-events',
        queryParameters: scheduleId != null ? {'schedule_id': scheduleId} : null,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      final events = (response.data as List)
          .map((json) => DutyEvent.fromJson(json))
          .toList();
      
      print('Parsed ${events.length} events');
      return events;
    } catch (e) {
      print('Error in getDutyEvents: $e');
      rethrow;
    }
  }

  Future<DutyEvent> getDutyEvent(int id) async {
    final response = await _dio.get('/duty-events/$id');
    return DutyEvent.fromJson(response.data);
  }

  Future<DutyEvent> updateDutyEventStatus(
    int id,
    DutyEventStatus status, {
    String? notes,
  }) async {
    print('=== ApiClient.updateDutyEventStatus() ===');
    print('Event ID: $id');
    print('Status: ${status.name}');
    print('Notes: $notes');
    
    final response = await _dio.put(
      '/duty-events/$id/status',
      data: {'status': status.name, if (notes != null) 'notes': notes},
    );
    
    print('Response: ${response.data}');
    return DutyEvent.fromJson(response.data);
  }

  // ==================== СВЯЗИ СТУДЕНТ-ГРУППА ====================
  
  Future<void> addStudentToGroup(int groupId, int studentId) async {
    await _dio.post('/groups/$groupId/students/$studentId');
  }

  Future<List<Student>> getGroupStudents(int groupId) async {
    print('=== ApiClient.getGroupStudents() ===');
    print('Group ID: $groupId');
    
    final response = await _dio.get('/groups/$groupId/students');
    
    // Сервер возвращает список StudentsGroup объектов
    // Каждый объект содержит поле 'student' с данными студента
    final List<dynamic> data = response.data;
    final List<Student> students = [];
    
    for (var item in data) {
      if (item is Map && item.containsKey('student')) {
        final studentJson = item['student'] as Map<String, dynamic>;
        students.add(Student.fromJson(studentJson));
      }
    }
    
    print('Found ${students.length} students in group $groupId');
    for (var student in students) {
      print('  - Student: ${student.id} - ${student.name}');
    }
    
    return students;
  }

  Future<void> removeStudentFromGroup(int groupId, int studentId) async {
    await _dio.delete('/groups/$groupId/students/$studentId');
  }
}

/// Retry-интерцептор для повторных запросов при разрыве соединения с облачной БД.
/// Облачные БД (Supabase/Neon/Railway) иногда разрывают idle-соединения,
/// сервер отвечает 500 с "Connection terminated unexpectedly".
/// При повторном запросе пул берёт свежее соединение — всё работает.
class _RetryInterceptor extends Interceptor {
  final Dio dio;

  /// Максимальное количество повторных попыток
  static const int _maxRetries = 5;

  /// Задержка между попытками (нарастающая: 500ms, 1000ms, 1500ms...)
  static const Duration _baseRetryDelay = Duration(milliseconds: 500);

  _RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final responseBody = err.response?.data?.toString() ?? '';
    final errorMessage = err.message ?? '';
    final errorType = err.type;

    // Логируем ошибку для отладки
    print('=== RetryInterceptor.onError ===');
    print('Error type: $errorType');
    print('Status code: $statusCode');
    print('Message: ${err.message}');
    print('Response body: ${responseBody.substring(0, responseBody.length > 200 ? 200 : responseBody.length)}');

    // Расширяем условия для повторных попыток
    final isConnectionTerminated = 
        (statusCode == 500 || statusCode == 503) &&
        (responseBody.contains('Connection terminated') ||
         responseBody.contains('connection terminated') ||
         responseBody.contains('Connection reset') ||
         responseBody.contains('timeout') ||
         responseBody.contains('time out') ||
         responseBody.contains('unexpectedly'));
    
    final isNetworkError = 
        errorType == DioExceptionType.connectionError ||
        errorType == DioExceptionType.receiveTimeout ||
        errorType == DioExceptionType.connectionTimeout ||
        errorType == DioExceptionType.sendTimeout;
    
    final isServerError = statusCode != null && statusCode >= 500;
    
    // Добавляем проверку на сообщение об ошибке
    final isConnectionError = errorMessage.toLowerCase().contains('connection') ||
                              errorMessage.toLowerCase().contains('terminated') ||
                              errorMessage.toLowerCase().contains('reset') ||
                              errorMessage.toLowerCase().contains('timeout');

    // Повторяем запрос при любых признаках проблем с соединением
    final shouldRetry = isConnectionTerminated || isNetworkError || isServerError || isConnectionError;

    if (!shouldRetry) {
      print('Not retrying - error not eligible for retry');
      return handler.next(err);
    }

    final attempt = (err.requestOptions.extra['_retryCount'] as int?) ?? 0;
    print('Retry attempt: $attempt/$_maxRetries');
    
    if (attempt >= _maxRetries) {
      print('Max retries reached, giving up');
      return handler.next(err);
    }

    // Увеличиваем счётчик попыток
    err.requestOptions.extra['_retryCount'] = attempt + 1;

    // Нарастающая задержка перед повтором
    final delay = _baseRetryDelay * (attempt + 1);
    print('Waiting ${delay.inMilliseconds}ms before retry...');
    await Future.delayed(delay);

    try {
      print('Retrying request: ${err.requestOptions.method} ${err.requestOptions.path}');
      final response = await dio.fetch(err.requestOptions);
      print('Retry successful!');
      return handler.resolve(response);
    } on DioException catch (e) {
      print('Retry failed: ${e.message}');
      return handler.next(e);
    }
  }
}

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') required String refreshToken,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
abstract class RefreshResponse with _$RefreshResponse {
  const factory RefreshResponse({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') required String refreshToken,
  }) = _RefreshResponse;

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseFromJson(json);
}

class RequestCodeResponse {
  final bool success;
  final bool alreadyExists;
  final String? message;

  RequestCodeResponse({
    required this.success,
    this.alreadyExists = false,
    this.message,
  });
}