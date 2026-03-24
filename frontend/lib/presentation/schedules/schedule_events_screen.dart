import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/data/models/duty_schedule.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/schedules/duty_events_provider.dart';
import 'package:frontend/presentation/groups/group_students_provider.dart';
import 'package:frontend/presentation/duty/duty_types_provider.dart';

class ScheduleEventsScreen extends ConsumerStatefulWidget {
  final DutySchedule schedule;
  const ScheduleEventsScreen({super.key, required this.schedule});

  @override
  ConsumerState<ScheduleEventsScreen> createState() =>
      _ScheduleEventsScreenState();
}

class _ScheduleEventsScreenState extends ConsumerState<ScheduleEventsScreen> {
  // Используем только дату без времени, чтобы избежать смещения UTC
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    print('=== ScheduleEventsScreen.initState() ===');
    print('Schedule ID: ${widget.schedule.id}');
    print('Group ID: ${widget.schedule.groupId}');
    print('Selected date: $_selectedDate');
    
    // Добавляем небольшую задержку для первого обновления
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dutyEventsProvider(widget.schedule.id).notifier).reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Загружаем события для данного расписания из API
    final eventsAsync = ref.watch(dutyEventsProvider(widget.schedule.id));
    
    // Загружаем студентов группы для отображения имён
    final groupStudentsAsync = ref.watch(groupStudentsProvider(widget.schedule.groupId));
    
    // Загружаем типы дежурств для отображения названия
    final dutyTypes = ref.watch(dutyTypesProvider).value ?? [];
    final dutyTypeName = dutyTypes
        .where((t) => t.id == widget.schedule.dutyTypeId)
        .map((t) => t.name)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'События расписания #${widget.schedule.id}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (dutyTypeName != null)
              Text(
                dutyTypeName,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _pickDate,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              print('Manual refresh triggered');
              await ref
                  .read(dutyEventsProvider(widget.schedule.id).notifier)
                  .reload();
              // Принудительно обновляем UI
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дата: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.auto_awesome),
                  onPressed: _generateEvents,
                  tooltip: 'Сгенерировать события',
                ),
              ],
            ),
          ),
          Expanded(
            child: eventsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ошибка загрузки событий: $e'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(dutyEventsProvider(widget.schedule.id).notifier)
                          .reload(),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
              data: (events) {
                print('=== Filtering events for date $_selectedDate ===');
                print('Total events in state: ${events.length}');
                
                // Фильтруем события для выбранной даты
                final eventsForDate = events.where((e) {
                  final localDate = e.dutyDate.toLocal();
                  final match = localDate.year == _selectedDate.year &&
                      localDate.month == _selectedDate.month &&
                      localDate.day == _selectedDate.day;
                  if (match) {
                    print('Found event for date: student=${e.studentId}, status=${e.status}');
                  }
                  return match;
                }).toList();
                
                print('Events for selected date: ${eventsForDate.length}');

                if (eventsForDate.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_busy, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Нет событий на эту дату'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _generateEvents,
                          icon: const Icon(Icons.auto_awesome),
                          label: const Text('Сгенерировать события'),
                        ),
                      ],
                    ),
                  );
                }

                final students = groupStudentsAsync.value ?? <Student>[];
                print('Students in group: ${students.length}');

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(dutyEventsProvider(widget.schedule.id).notifier)
                        .reload();
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: eventsForDate.length,
                    itemBuilder: (ctx, i) {
                      final event = eventsForDate[i];
                      final student = students.firstWhere(
                        (s) => s.id == event.studentId,
                        orElse: () {
                          print('Student ${event.studentId} not found in group ${widget.schedule.groupId}');
                          return Student(
                            id: event.studentId,
                            name: 'Студент #${event.studentId}',
                            isActive: false,
                            dutyScore: 0,
                          );
                        },
                      );
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: _getStatusIcon(event.status),
                          title: Text(
                            student.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Статус: ${_statusText(event.status)}',
                          ),
                          trailing: PopupMenuButton<DutyEventStatus>(
                            onSelected: (status) async {
                              print('Updating event ${event.id} to status $status');
                              final error = await ref
                                  .read(dutyEventsProvider(widget.schedule.id).notifier)
                                  .updateEventStatus(event.id, status);
                              if (error != null && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Не удалось обновить статус: $error'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Статус обновлен'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                // Принудительно обновляем UI
                                setState(() {});
                              }
                            },
                            itemBuilder: (ctx) => [
                              const PopupMenuItem(
                                value: DutyEventStatus.completed,
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text('Выполнено'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: DutyEventStatus.cancelled,
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Отменено'),
                                  ],
                                ),
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

  Widget _getStatusIcon(DutyEventStatus status) {
    switch (status) {
      case DutyEventStatus.pending:
        return const Icon(Icons.pending, color: Colors.orange, size: 28);
      case DutyEventStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 28);
      case DutyEventStatus.cancelled:
        return const Icon(Icons.cancel, color: Colors.red, size: 28);
      case DutyEventStatus.reassigned:
        return const Icon(Icons.swap_horiz, color: Colors.blue, size: 28);
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
      print('Date changed to: $date');
      setState(() {
        _selectedDate = DateTime(date.year, date.month, date.day);
      });
      // При смене даты не нужно перезагружать все события, просто фильтр изменится
    }
  }

  Future<void> _generateEvents() async {
    print('=== Generating events ===');
    print('Schedule ID: ${widget.schedule.id}');
    print('Date: $_selectedDate');
    
    // Показываем индикатор загрузки
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );
    
    final error = await ref
        .read(dutyEventsProvider(widget.schedule.id).notifier)
        .generateEvents(_selectedDate);
    
    // Закрываем диалог загрузки
    if (mounted) {
      Navigator.pop(context);
    }
    
    if (mounted) {
      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('События успешно сгенерированы'),
            backgroundColor: Colors.green,
          ),
        );
        // Принудительно обновляем UI
        setState(() {});
        
        // Дополнительно перезагружаем для уверенности
        await ref.read(dutyEventsProvider(widget.schedule.id).notifier).reload();
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Не удалось сгенерировать события: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}