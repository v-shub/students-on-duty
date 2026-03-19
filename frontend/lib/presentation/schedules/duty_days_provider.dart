import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_day.dart';

final _daysStorage = <int, DutyDay>{};

class DutyDaysNotifier extends StateNotifier<Map<int, DutyDay>> {
  DutyDaysNotifier() : super(_daysStorage);

  DutyDay getForSchedule(int scheduleId) {
    return state[scheduleId] ?? DutyDay(scheduleId: scheduleId);
  }

  void setDays(int scheduleId, DutyDay days) {
    // Убедимся, что scheduleId правильный
    final correctedDays = days.copyWith(scheduleId: scheduleId);
    state = {...state, scheduleId: correctedDays};
  }

  void updateDays(int scheduleId, DutyDay updated) {
    final current = state[scheduleId] ?? DutyDay(scheduleId: scheduleId);
    final merged = DutyDay(
      scheduleId: scheduleId,
      isMonday: updated.isMonday ?? current.isMonday,
      isTuesday: updated.isTuesday ?? current.isTuesday,
      isWednesday: updated.isWednesday ?? current.isWednesday,
      isThursday: updated.isThursday ?? current.isThursday,
      isFriday: updated.isFriday ?? current.isFriday,
      isSaturday: updated.isSaturday ?? current.isSaturday,
      isSunday: updated.isSunday ?? current.isSunday,
    );
    state = {...state, scheduleId: merged};
  }

  void removeDays(int scheduleId) {
    final newState = Map<int, DutyDay>.from(state);
    newState.remove(scheduleId);
    state = newState;
  }
}

final dutyDaysProvider =
    StateNotifierProvider<DutyDaysNotifier, Map<int, DutyDay>>((ref) {
      return DutyDaysNotifier();
    });
