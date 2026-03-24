import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/duty_type.dart';
import 'package:frontend/data/models/group.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/data/services/api_client.dart';

/// Модель объединённых данных о событии дежурства для отображения на главном экране
class DutyEventInfo {
  final DutyEvent event;
  final Student student;
  final DutySchedule schedule;
  final DutyType? dutyType;
  final Group? group;

  const DutyEventInfo({
    required this.event,
    required this.student,
    required this.schedule,
    this.dutyType,
    this.group,
  });
}

/// Провайдер событий дежурств на конкретную дату (по умолчанию — сегодня)
class TodayDutyNotifier extends AsyncNotifier<List<DutyEventInfo>> {
  DateTime _date = _today();

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get date => _date;

  @override
  Future<List<DutyEventInfo>> build() async {
    return _loadForDate(_date);
  }

  /// Загрузить события на указанную дату
  Future<List<DutyEventInfo>> _loadForDate(DateTime date) async {
    final api = ref.read(apiClientProvider);

    // Загружаем все необходимые данные параллельно
    final results = await Future.wait([
      api.getDutyEvents(),
      api.getDutySchedules(),
      api.getDutyTypes(),
      api.getGroups(),
      api.getStudents(),
    ]);

    final allEvents = results[0] as List<DutyEvent>;
    final allSchedules = results[1] as List<DutySchedule>;
    final allTypes = results[2] as List<DutyType>;
    final allGroups = results[3] as List<Group>;
    final allStudents = results[4] as List<Student>;

    // Фильтруем события по выбранной дате
    final eventsForDate = allEvents.where((e) {
      final local = e.dutyDate.toLocal();
      return local.year == date.year &&
          local.month == date.month &&
          local.day == date.day;
    }).toList();

    // Собираем обогащённую информацию по каждому событию
    final result = <DutyEventInfo>[];
    for (final event in eventsForDate) {
      final student = allStudents.firstWhere(
        (s) => s.id == event.studentId,
        orElse: () => Student(
          id: event.studentId,
          name: 'Студент #${event.studentId}',
          isActive: false,
          dutyScore: 0,
        ),
      );
      final schedule = allSchedules.firstWhere(
        (s) => s.id == event.scheduleId,
        orElse: () => DutySchedule(
          id: event.scheduleId,
          groupId: 0,
          dutyTypeId: 0,
          studentsPerDay: 1,
          startDate: date,
        ),
      );
      final dutyType = allTypes.where((t) => t.id == schedule.dutyTypeId).firstOrNull;
      final group = allGroups.where((g) => g.id == schedule.groupId).firstOrNull;

      result.add(DutyEventInfo(
        event: event,
        student: student,
        schedule: schedule,
        dutyType: dutyType,
        group: group,
      ));
    }

    // Сортируем: сначала pending, потом остальные
    result.sort((a, b) {
      if (a.event.status == DutyEventStatus.pending &&
          b.event.status != DutyEventStatus.pending) return -1;
      if (a.event.status != DutyEventStatus.pending &&
          b.event.status == DutyEventStatus.pending) return 1;
      return a.student.name.compareTo(b.student.name);
    });

    return result;
  }

  /// Перейти на другую дату
  Future<void> selectDate(DateTime date) async {
    _date = DateTime(date.year, date.month, date.day);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadForDate(_date));
  }

  /// Перезагрузить текущую дату
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadForDate(_date));
  }

  /// Обновить статус события и обновить список
  Future<String?> updateEventStatus(
    int eventId,
    DutyEventStatus status, {
    String? notes,
  }) async {
    try {
      final updated = await ref
          .read(apiClientProvider)
          .updateDutyEventStatus(eventId, status, notes: notes);

      // Обновляем только изменённое событие в текущем списке
      final current = state.value ?? [];
      state = AsyncValue.data([
        for (final info in current)
          if (info.event.id == updated.id)
            DutyEventInfo(
              event: updated,
              student: info.student,
              schedule: info.schedule,
              dutyType: info.dutyType,
              group: info.group,
            )
          else
            info,
      ]);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

final todayDutyProvider =
    AsyncNotifierProvider<TodayDutyNotifier, List<DutyEventInfo>>(
      TodayDutyNotifier.new,
    );