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
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
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
        // Пользователь уже существует, но код отправлен
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

  // Для обратной совместимости (deprecated)
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
  
  Future<Student> createStudent(String name, {bool isActive = true}) async {
    final response = await _dio.post(
      '/students',
      data: {'name': name, 'is_active': isActive},
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
    final response = await _dio.post(
      '/duty-events/generate',
      data: {
        'schedule_id': scheduleId,
        'date': date.toIso8601String().split('T').first,
      },
    );
    return (response.data as List)
        .map((json) => DutyEvent.fromJson(json))
        .toList();
  }

  Future<List<DutyEvent>> getDutyEvents({int? scheduleId}) async {
    final response = await _dio.get(
      '/duty-events',
      queryParameters: scheduleId != null ? {'schedule_id': scheduleId} : null,
    );
    return (response.data as List)
        .map((json) => DutyEvent.fromJson(json))
        .toList();
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
    final response = await _dio.put(
      '/duty-events/$id/status',
      data: {'status': status.name, if (notes != null) 'notes': notes},
    );
    return DutyEvent.fromJson(response.data);
  }

  // ==================== СВЯЗИ СТУДЕНТ-ГРУППА ====================
  
Future<void> addStudentToGroup(int groupId, int studentId) async {
  await _dio.post('/groups/$groupId/students/$studentId');
}

Future<List<Student>> getGroupStudents(int groupId) async {
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
  
  return students;
}

Future<void> removeStudentFromGroup(int groupId, int studentId) async {
  await _dio.delete('/groups/$groupId/students/$studentId');
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