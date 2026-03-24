import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/data/models/dto/create_duty_schedule_dto.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер расписаний для конкретной группы — данные загружаются из API
class GroupSchedulesNotifier extends AsyncNotifier<List<DutySchedule>> {
  final int _groupId;

  GroupSchedulesNotifier(this._groupId);

  @override
  Future<List<DutySchedule>> build() async {
    // Загружаем все расписания и фильтруем по groupId
    final all = await ref.read(apiClientProvider).getDutySchedules();
    return all.where((s) => s.groupId == _groupId).toList();
  }

  /// Перезагрузить расписания из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final all = await ref.read(apiClientProvider).getDutySchedules();
      return all.where((s) => s.groupId == _groupId).toList();
    });
  }

  /// Создать расписание через API (дни недели передаются в теле запроса)
  Future<DutySchedule?> createSchedule({
    required int dutyTypeId,
    required int studentsPerDay,
    required DateTime startDate,
    DateTime? endDate,
    required DutyDay days,
  }) async {
    try {
      // Формируем Map дней недели для API
      final dutyDaysMap = <String, bool>{
        'is_monday': days.isMonday,
        'is_tuesday': days.isTuesday,
        'is_wednesday': days.isWednesday,
        'is_thursday': days.isThursday,
        'is_friday': days.isFriday,
        'is_saturday': days.isSaturday,
        'is_sunday': days.isSunday,
      };

      final dto = CreateDutyScheduleDto(
        groupId: _groupId,
        dutyTypeId: dutyTypeId,
        studentsPerDay: studentsPerDay,
        startDate: startDate.toIso8601String().split('T').first,
        endDate: endDate?.toIso8601String().split('T').first,
        dutyDays: dutyDaysMap,
      );

      final created = await ref.read(apiClientProvider).createDutySchedule(dto);
      state = AsyncValue.data([...state.value ?? [], created]);
      return created;
    } catch (e) {
      return null;
    }
  }

  /// Удалить расписание через API
  Future<bool> deleteSchedule(int scheduleId) async {
    try {
      await ref.read(apiClientProvider).deleteDutySchedule(scheduleId);
      state = AsyncValue.data(
        (state.value ?? []).where((s) => s.id != scheduleId).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

final groupSchedulesProvider = AsyncNotifierProvider.family<
    GroupSchedulesNotifier,
    List<DutySchedule>,
    int>((arg) => GroupSchedulesNotifier(arg));
