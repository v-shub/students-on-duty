import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер событий дежурств для конкретного расписания — данные из API
class DutyEventsNotifier extends AsyncNotifier<List<DutyEvent>> {
  final int _scheduleId;

  DutyEventsNotifier(this._scheduleId);

  @override
  Future<List<DutyEvent>> build() async {
    print('=== DutyEventsNotifier.build() ===');
    print('Loading events for schedule: $_scheduleId');
    try {
      final events = await ref
          .read(apiClientProvider)
          .getDutyEvents(scheduleId: _scheduleId);
      print('Loaded ${events.length} events for schedule $_scheduleId');
      if (events.isNotEmpty) {
        print('First event date: ${events.first.dutyDate}');
      }
      return events;
    } catch (e) {
      print('Error loading events: $e');
      rethrow;
    }
  }

  /// Перезагрузить события из API
  Future<void> reload() async {
    print('=== DutyEventsNotifier.reload() ===');
    print('Reloading events for schedule: $_scheduleId');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final events = await ref
            .read(apiClientProvider)
            .getDutyEvents(scheduleId: _scheduleId);
        print('Reloaded ${events.length} events');
        return events;
      },
    );
  }

  /// Сгенерировать события на дату через API
  /// Возвращает null при успехе, строку с ошибкой при неудаче
  Future<String?> generateEvents(DateTime date) async {
    print('=== DutyEventsNotifier.generateEvents() ===');
    print('Generating events for schedule: $_scheduleId, date: $date');
    
    try {
      final newEvents = await ref
          .read(apiClientProvider)
          .generateDutyEvents(_scheduleId, date);
      
      print('Generated ${newEvents.length} new events');
      for (var event in newEvents) {
        print('  - Event: student=${event.studentId}, date=${event.dutyDate}, status=${event.status}');
      }
      
      if (newEvents.isEmpty) {
        print('No events generated');
        return 'No events generated';
      }
      
      // Получаем текущие события
      final currentEvents = state.value ?? [];
      print('Current events count: ${currentEvents.length}');
      
      // Нормализуем выбранную дату (без времени)
      final normalizedSelectedDate = DateTime(date.year, date.month, date.day);
      
      // Фильтруем существующие события, удаляя события на выбранную дату
      final existingEvents = currentEvents.where((e) {
        final eventDate = DateTime(e.dutyDate.year, e.dutyDate.month, e.dutyDate.day);
        final shouldKeep = eventDate != normalizedSelectedDate;
        if (!shouldKeep) {
          print('Removing existing event for date: ${e.dutyDate}');
        }
        return shouldKeep;
      }).toList();
      
      print('Kept ${existingEvents.length} existing events');
      
      // Объединяем и сортируем по дате
      final allEvents = [...existingEvents, ...newEvents]..sort((a, b) => 
        a.dutyDate.compareTo(b.dutyDate)
      );
      
      print('Total events after generation: ${allEvents.length}');
      
      // Обновляем состояние
      state = AsyncValue.data(allEvents);
      print('State updated with new events');
      
      return null;
    } catch (e, stack) {
      print('Error generating events: $e');
      print('Stack trace: $stack');
      return e.toString();
    }
  }

  /// Обновить статус события через API
  Future<String?> updateEventStatus(
    int eventId,
    DutyEventStatus status, {
    String? notes,
  }) async {
    print('=== DutyEventsNotifier.updateEventStatus() ===');
    print('Updating event $eventId to status $status');
    
    try {
      final updated = await ref
          .read(apiClientProvider)
          .updateDutyEventStatus(eventId, status, notes: notes);
      
      final currentEvents = state.value ?? [];
      final updatedEvents = currentEvents.map((e) {
        return e.id == updated.id ? updated : e;
      }).toList();
      
      state = AsyncValue.data(updatedEvents);
      print('Event $eventId updated successfully');
      
      return null;
    } catch (e) {
      print('Error updating event: $e');
      return e.toString();
    }
  }
}

final dutyEventsProvider =
    AsyncNotifierProvider.family<DutyEventsNotifier, List<DutyEvent>, int>(
      (arg) => DutyEventsNotifier(arg),
    );