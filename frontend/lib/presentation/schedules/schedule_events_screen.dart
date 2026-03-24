import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/schedules/duty_events_provider.dart';
import 'package:frontend/presentation/groups/group_students_tab.dart';

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
    // Загружаем события для данного расписания из API
    final eventsAsync =
        ref.watch(dutyEventsProvider(widget.schedule.id));
    // Загружаем студентов группы для отображения имён
    final groupStudentsAsync =
        ref.watch(groupStudentsProvider(widget.schedule.groupId));

    return Scaffold(
      appBar: AppBar(
        title: Text('События расписания #${widget.schedule.id}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _pickDate,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(dutyEventsProvider(widget.schedule.id).notifier)
                .reload(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Дата: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: eventsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Ошибка загрузки событий: $e')),
              data: (events) {
                final eventsForDate = events
                    .where(
                      (e) =>
                          e.dutyDate.year == _selectedDate.year &&
                          e.dutyDate.month == _selectedDate.month &&
                          e.dutyDate.day == _selectedDate.day,
                    )
                    .toList();

                if (eventsForDate.isEmpty) {
                  return const Center(
                    child: Text('Нет событий на эту дату'),
                  );
                }

                final students =
                    groupStudentsAsync.value ?? <Student>[];

                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(
                        dutyEventsProvider(widget.schedule.id).notifier,
                      )
                      .reload(),
                  child: ListView.builder(
                    itemCount: eventsForDate.length,
                    itemBuilder: (ctx, i) {
                      final event = eventsForDate[i];
                      final student = students.firstWhere(
                        (s) => s.id == event.studentId,
                        orElse: () => Student(
                          id: event.studentId,
                          name: 'Студент #${event.studentId}',
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
                            onSelected: (status) async {
                              // Обновляем статус через API
                              // API принимает только completed и cancelled
                              if (status == DutyEventStatus.pending ||
                                  status ==
                                      DutyEventStatus.reassigned) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Недопустимый статус для ручного изменения',
                                    ),
                                  ),
                                );
                                return;
                              }
                              final ok = await ref
                                  .read(
                                    dutyEventsProvider(
                                      widget.schedule.id,
                                    ).notifier,
                                  )
                                  .updateEventStatus(event.id, status);
                              if (!ok && context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Не удалось обновить статус',
                                    ),
                                  ),
                                );
                              }
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateEvents,
        tooltip: 'Сгенерировать события на выбранную дату',
        child: const Icon(Icons.auto_awesome),
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
    // Генерируем события через API — бэкенд сам выбирает студентов
    final ok = await ref
        .read(dutyEventsProvider(widget.schedule.id).notifier)
        .generateEvents(_selectedDate);

    if (mounted) {
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('События успешно сгенерированы')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Не удалось сгенерировать события. '
              'Проверьте наличие активных студентов в группе.',
            ),
          ),
        );
      }
    }
  }
}
