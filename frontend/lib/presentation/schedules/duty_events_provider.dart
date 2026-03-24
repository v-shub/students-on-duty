import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер событий дежурств для конкретного расписания — данные из API
class DutyEventsNotifier extends AsyncNotifier<List<DutyEvent>> {
  final int _scheduleId;

  DutyEventsNotifier(this._scheduleId);

  @override
  Future<List<DutyEvent>> build() async {
    return await ref
        .read(apiClientProvider)
        .getDutyEvents(scheduleId: _scheduleId);
  }

  /// Перезагрузить события из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(apiClientProvider)
          .getDutyEvents(scheduleId: _scheduleId),
    );
  }

  /// Сгенерировать события на дату через API
  Future<bool> generateEvents(DateTime date) async {
    try {
      final newEvents = await ref
          .read(apiClientProvider)
          .generateDutyEvents(_scheduleId, date);
      state = AsyncValue.data([...state.value ?? [], ...newEvents]);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Обновить статус события через API
  Future<bool> updateEventStatus(
    int eventId,
    DutyEventStatus status, {
    String? notes,
  }) async {
    try {
      final updated = await ref
          .read(apiClientProvider)
          .updateDutyEventStatus(eventId, status, notes: notes);
      state = AsyncValue.data([
        for (final e in state.value ?? [])
          if (e.id == updated.id) updated else e,
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }
}

final dutyEventsProvider =
    AsyncNotifierProvider.family<DutyEventsNotifier, List<DutyEvent>, int>(
      (arg) => DutyEventsNotifier(arg),
    );
