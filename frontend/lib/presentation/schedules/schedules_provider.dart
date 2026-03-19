import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/presentation/schedules/duty_days_provider.dart';

// Хранилище расписаний для каждой группы (ключ – groupId)
final _schedulesStorage = <int, List<DutySchedule>>{};

class GroupSchedulesNotifier extends StateNotifier<List<DutySchedule>> {
  final int groupId;
  final Ref ref;

  GroupSchedulesNotifier(this.ref, this.groupId)
    : super(_schedulesStorage[groupId] ?? []) {
    if (_schedulesStorage[groupId] == null) {
      _schedulesStorage[groupId] = [];
      state = [];
    }
  }

  int _nextId() {
    if (state.isEmpty) return 1;
    return state.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> createSchedule({
    required int dutyTypeId,
    required int studentsPerDay,
    required DateTime startDate,
    DateTime? endDate,
    required DutyDay days,
  }) async {
    final newId = _nextId();
    final newSchedule = DutySchedule(
      id: newId,
      groupId: groupId,
      dutyTypeId: dutyTypeId,
      studentsPerDay: studentsPerDay,
      startDate: startDate,
      endDate: endDate,
      isActive: true,
    );
    final newList = [...state, newSchedule];
    _schedulesStorage[groupId] = newList;
    state = newList;

    // Сохраняем дни недели для этого расписания
    ref.read(dutyDaysProvider.notifier).setDays(newId, days);
  }

  Future<void> updateSchedule(DutySchedule updated) async {
    final newList = state.map((s) => s.id == updated.id ? updated : s).toList();
    _schedulesStorage[groupId] = newList;
    state = newList;
  }

  Future<void> deleteSchedule(int scheduleId) async {
    final newList = state.where((s) => s.id != scheduleId).toList();
    _schedulesStorage[groupId] = newList;
    state = newList;
    // Также удаляем дни
    ref.read(dutyDaysProvider.notifier).removeDays(scheduleId);
  }
}

final groupSchedulesProvider =
    StateNotifierProvider.family<
      GroupSchedulesNotifier,
      List<DutySchedule>,
      int
    >((ref, groupId) {
      return GroupSchedulesNotifier(ref, groupId);
    });
