import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';

// Хранилище событий для каждого расписания
final _eventsStorage = <int, List<DutyEvent>>{};

class DutyEventsNotifier extends StateNotifier<Map<int, List<DutyEvent>>> {
  DutyEventsNotifier() : super(_eventsStorage);

  // Получить события для конкретного расписания
  List<DutyEvent> getForSchedule(int scheduleId) {
    return state[scheduleId] ?? [];
  }

  // Сгенерировать события на определённую дату (ручная генерация)
  Future<void> generateEvents(
    int scheduleId,
    DateTime date,
    List<int> studentIds,
  ) async {
    final current = List<DutyEvent>.from(state[scheduleId] ?? []);
    // Простая генерация: создаём событие для каждого студента
    final newEvents = studentIds
        .map(
          (studentId) => DutyEvent(
            id: _nextId(scheduleId),
            studentId: studentId,
            scheduleId: scheduleId,
            dutyDate: date,
            status: DutyEventStatus.pending,
            scoreEarned: null,
            notes: null,
            assignedAt: DateTime.now(),
          ),
        )
        .toList();

    final updated = [...current, ...newEvents];
    _eventsStorage[scheduleId] = updated;
    state = {...state, scheduleId: updated};
  }

  // Обновить статус события
  Future<void> updateEventStatus(
    int scheduleId,
    int eventId,
    DutyEventStatus status, {
    String? notes,
  }) async {
    final current = List<DutyEvent>.from(state[scheduleId] ?? []);
    final index = current.indexWhere((e) => e.id == eventId);
    if (index == -1) return;

    final updatedEvent = current[index].copyWith(
      status: status,
      notes: notes ?? current[index].notes,
    );
    current[index] = updatedEvent;
    _eventsStorage[scheduleId] = current;
    state = {...state, scheduleId: current};
  }

  int _nextId(int scheduleId) {
    final events = state[scheduleId] ?? [];
    if (events.isEmpty) return 1;
    return events.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
  }
}

final dutyEventsProvider =
    StateNotifierProvider<DutyEventsNotifier, Map<int, List<DutyEvent>>>((ref) {
      return DutyEventsNotifier();
    });
