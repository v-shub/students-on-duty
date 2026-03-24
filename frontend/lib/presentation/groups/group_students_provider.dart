// lib/presentation/groups/group_students_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер студентов конкретной группы — данные загружаются из API
class GroupStudentsNotifier extends AsyncNotifier<List<Student>> {
  final int _groupId;

  GroupStudentsNotifier(this._groupId);

  @override
  Future<List<Student>> build() async {
    return await ref.read(apiClientProvider).getGroupStudents(_groupId);
  }

  /// Перезагрузить список студентов группы из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiClientProvider).getGroupStudents(_groupId),
    );
  }

  /// Добавить существующего студента в группу через API
  Future<bool> addStudentToGroup(int studentId) async {
    try {
      await ref
          .read(apiClientProvider)
          .addStudentToGroup(_groupId, studentId);
      await reload();
      return true;
    } catch (e) {
      debugPrint('Error adding student to group: $e');
      return false;
    }
  }

  /// Удалить студента из группы через API
  Future<bool> removeStudentFromGroup(int studentId) async {
    try {
      await ref
          .read(apiClientProvider)
          .removeStudentFromGroup(_groupId, studentId);
      // Обновляем состояние локально без полной перезагрузки
      final currentStudents = state.value ?? [];
      state = AsyncValue.data(
        currentStudents.where((s) => s.id != studentId).toList(),
      );
      return true;
    } catch (e) {
      debugPrint('Error removing student from group: $e');
      return false;
    }
  }
}

final groupStudentsProvider =
    AsyncNotifierProvider.family<GroupStudentsNotifier, List<Student>, int>(
      (arg) => GroupStudentsNotifier(arg),
    );