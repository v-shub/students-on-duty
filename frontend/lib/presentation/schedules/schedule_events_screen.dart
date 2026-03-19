import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/schedules/duty_events_provider.dart';
import 'package:frontend/presentation/groups/group_students_tab.dart'; // для groupStudentsProvider
import 'package:frontend/presentation/students/all_students_provider.dart';

class ScheduleEventsScreen extends ConsumerStatefulWidget {
  final DutySchedule schedule;
  const ScheduleEventsScreen({super.key, required this.schedule});

  @override
  ConsumerState<ScheduleEventsScreen> createState() =>
      _ScheduleEventsScreenState();
}

class _ScheduleEventsScreenState extends ConsumerState<ScheduleEventsScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(dutyEventsProvider)[widget.schedule.id] ?? [];
    final groupStudents = ref.watch(
      groupStudentsProvider(widget.schedule.groupId),
    );
    final allStudents = ref.watch(allStudentsProvider);

    final eventsForDate = events
        .where(
          (e) =>
              e.dutyDate.year == _selectedDate.year &&
              e.dutyDate.month == _selectedDate.month &&
              e.dutyDate.day == _selectedDate.day,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('События расписания #${widget.schedule.id}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Дата: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: eventsForDate.isEmpty
                ? const Center(child: Text('Нет событий на эту дату'))
                : ListView.builder(
                    itemCount: eventsForDate.length,
                    itemBuilder: (ctx, i) {
                      final event = eventsForDate[i];
                      final student = allStudents.firstWhere(
                        (s) => s.id == event.studentId,
                        orElse: () => Student(
                          id: event.studentId,
                          name: 'Неизвестно',
                          isActive: false,
                          dutyScore: 0,
                        ),
                      );
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text(
                            'Статус: ${_statusText(event.status)}',
                          ),
                          trailing: PopupMenuButton<DutyEventStatus>(
                            onSelected: (status) {
                              ref
                                  .read(dutyEventsProvider.notifier)
                                  .updateEventStatus(
                                    widget.schedule.id,
                                    event.id,
                                    status,
                                  );
                            },
                            itemBuilder: (ctx) => [
                              const PopupMenuItem(
                                value: DutyEventStatus.completed,
                                child: Text('Выполнено'),
                              ),
                              const PopupMenuItem(
                                value: DutyEventStatus.cancelled,
                                child: Text('Отменено'),
                              ),
                              const PopupMenuItem(
                                value: DutyEventStatus.pending,
                                child: Text('Ожидает'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateEvents,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _statusText(DutyEventStatus status) {
    switch (status) {
      case DutyEventStatus.pending:
        return 'Ожидает';
      case DutyEventStatus.completed:
        return 'Выполнено';
      case DutyEventStatus.cancelled:
        return 'Отменено';
      case DutyEventStatus.reassigned:
        return 'Переназначено';
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _generateEvents() async {
    // Получаем актуальный список студентов группы
    final groupStudents = ref.read(
      groupStudentsProvider(widget.schedule.groupId),
    );
    if (groupStudents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('В группе нет студентов для генерации событий'),
        ),
      );
      return;
    }
    final studentIds = groupStudents.map((s) => s.id).toList();
    await ref
        .read(dutyEventsProvider.notifier)
        .generateEvents(widget.schedule.id, _selectedDate, studentIds);
    // Обновляем UI
    setState(() {});
  }
}
