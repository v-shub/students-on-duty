// absences_provider.dart - исправленный провайдер

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/absence.dart';
import 'package:frontend/data/models/dto/create_absence_dto.dart';
import 'package:frontend/data/models/dto/update_absence_dto.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер отсутствий для конкретного студента
class StudentAbsencesNotifier extends AsyncNotifier<List<Absence>> {
  final int _studentId;

  StudentAbsencesNotifier(this._studentId);

  @override
  Future<List<Absence>> build() async {
    return await ref
        .read(apiClientProvider)
        .getAbsences(studentId: _studentId);
  }

  /// Перезагрузить отсутствия из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiClientProvider).getAbsences(studentId: _studentId),
    );
  }

  /// Создать отсутствие через API
  Future<String?> createAbsence({
    required DateTime dateFrom,
    required DateTime dateTo,
    String? reason,
    bool isApproved = false,
  }) async {
    try {
      final dto = CreateAbsenceDto(
        studentId: _studentId,
        dateFrom: _formatDate(dateFrom),
        dateTo: _formatDate(dateTo),
        reason: reason,
        isApproved: isApproved,
      );
      final created = await ref.read(apiClientProvider).createAbsence(dto);
      
      // Обновляем локальное состояние
      final currentList = state.value ?? [];
      state = AsyncValue.data([...currentList, created]);
      
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Обновить отсутствие через API
  Future<String?> updateAbsence(
    int absenceId, {
    DateTime? dateFrom,
    DateTime? dateTo,
    String? reason,
    bool? isApproved,
  }) async {
    try {
      final dto = UpdateAbsenceDto(
        dateFrom: dateFrom != null ? _formatDate(dateFrom) : null,
        dateTo: dateTo != null ? _formatDate(dateTo) : null,
        reason: reason,
        isApproved: isApproved,
      );
      final updated = await ref.read(apiClientProvider).updateAbsence(absenceId, dto);
      
      // Обновляем локальное состояние
      state = AsyncValue.data([
        for (final a in state.value ?? [])
          if (a.id == updated.id) updated else a,
      ]);
      
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Удалить отсутствие через API
  Future<String?> deleteAbsence(int absenceId) async {
    try {
      await ref.read(apiClientProvider).deleteAbsence(absenceId);
      
      // Обновляем локальное состояние
      state = AsyncValue.data(
        (state.value ?? []).where((a) => a.id != absenceId).toList(),
      );
      
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

final studentAbsencesProvider = AsyncNotifierProvider.family<
    StudentAbsencesNotifier,
    List<Absence>,
    int>((arg) => StudentAbsencesNotifier(arg));