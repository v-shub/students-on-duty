import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/data/models/dto/update_duty_day_dto.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер дней дежурств для конкретного расписания — данные из API
class DutyDayNotifier extends AsyncNotifier<DutyDay?> {
  final int _scheduleId;

  DutyDayNotifier(this._scheduleId);

  @override
  Future<DutyDay?> build() async {
    try {
      return await ref
          .read(apiClientProvider)
          .getDutyDaysBySchedule(_scheduleId);
    } catch (e) {
      // Если дни не найдены — возвращаем null (не ошибка)
      return null;
    }
  }

  /// Обновить дни через API
  Future<bool> updateDays(DutyDay days) async {
    try {
      final dto = UpdateDutyDayDto(
        isMonday: days.isMonday,
        isTuesday: days.isTuesday,
        isWednesday: days.isWednesday,
        isThursday: days.isThursday,
        isFriday: days.isFriday,
        isSaturday: days.isSaturday,
        isSunday: days.isSunday,
      );
      final updated = await ref
          .read(apiClientProvider)
          .updateDutyDay(_scheduleId, dto);
      state = AsyncValue.data(updated);
      return true;
    } catch (e) {
      return false;
    }
  }
}

final dutyDayProvider =
    AsyncNotifierProvider.family<DutyDayNotifier, DutyDay?, int>(
      (arg) => DutyDayNotifier(arg),
    );

// Обратная совместимость: провайдер кэша всех дней (заполняется при загрузке расписаний)
// Используется в GroupSchedulesTab для отображения дней без дополнительных запросов
class DutyDaysCacheNotifier extends Notifier<Map<int, DutyDay>> {
  @override
  Map<int, DutyDay> build() => {};

  void setDays(int scheduleId, DutyDay days) {
    state = {...state, scheduleId: days.copyWith(scheduleId: scheduleId)};
  }

  void removeDays(int scheduleId) {
    final newState = Map<int, DutyDay>.from(state);
    newState.remove(scheduleId);
    state = newState;
  }
}

final dutyDaysProvider =
    NotifierProvider<DutyDaysCacheNotifier, Map<int, DutyDay>>(
      DutyDaysCacheNotifier.new,
    );
