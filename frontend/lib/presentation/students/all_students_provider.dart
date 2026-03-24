import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';

import 'package:frontend/data/services/api_client.dart';

/// Провайдер всех студентов пользователя — загружается из API
class AllStudentsNotifier extends AsyncNotifier<List<Student>> {
  @override
  Future<List<Student>> build() async {
    return await ref.read(apiClientProvider).getStudents();
  }

  /// Обновить список из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiClientProvider).getStudents(),
    );
  }

  /// Создать нового студента через API и добавить в список
  Future<Student?> createStudent(String name, {bool isActive = true}) async {
    try {
      final student = await ref
          .read(apiClientProvider)
          .createStudent(name, isActive: isActive);
      state = AsyncValue.data([...state.value ?? [], student]);
      return student;
    } catch (e) {
      return null;
    }
  }

  /// Обновить студента через API
  Future<bool> updateStudent(
    int id, {
    String? name,
    bool? isActive,
  }) async {
    try {
      final updated = await ref
          .read(apiClientProvider)
          .updateStudent(id, name: name, isActive: isActive);
      state = AsyncValue.data([
        for (final s in state.value ?? [])
          if (s.id == updated.id) updated else s,
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Удалить студента через API
  Future<bool> deleteStudent(int id) async {
    try {
      await ref.read(apiClientProvider).deleteStudent(id);
      state = AsyncValue.data(
        (state.value ?? []).where((s) => s.id != id).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Найти студента по id в текущем списке
  Student? getById(int id) {
    try {
      return state.value?.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }
}

final allStudentsProvider =
    AsyncNotifierProvider<AllStudentsNotifier, List<Student>>(
      AllStudentsNotifier.new,
    );
