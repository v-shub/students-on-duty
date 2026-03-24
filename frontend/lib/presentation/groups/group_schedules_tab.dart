import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/presentation/schedules/schedules_provider.dart';
import 'package:frontend/presentation/schedules/duty_days_provider.dart';
import 'package:frontend/presentation/schedules/create_schedule_screen.dart';
import 'package:frontend/presentation/schedules/schedule_events_screen.dart';

class GroupSchedulesTab extends ConsumerWidget {
  final int groupId;
  const GroupSchedulesTab({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(groupSchedulesProvider(groupId));

    return Scaffold(
      body: schedulesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Ошибка загрузки расписаний: $e')),
        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(
              child: Text('Нет расписаний для этой группы'),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref
                .read(groupSchedulesProvider(groupId).notifier)
                .reload(),
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (ctx, i) {
                final schedule = schedules[i];
                // Загружаем дни дежурств для этого расписания из API
                final daysAsync =
                    ref.watch(dutyDayProvider(schedule.id));
                final days = daysAsync.value ??
                    DutyDay(scheduleId: schedule.id);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text('Расписание #${schedule.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Тип дежурства: ${schedule.dutyTypeId}'),
                        Text(
                          'Студентов в день: ${schedule.studentsPerDay}',
                        ),
                        Text(
                          'Период: ${_formatDate(schedule.startDate)}'
                          ' - '
                          '${schedule.endDate != null ? _formatDate(schedule.endDate!) : '∞'}',
                        ),
                        Text('Дни: ${_formatDays(days)}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _deleteSchedule(context, ref, schedule.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ScheduleEventsScreen(schedule: schedule),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateScheduleScreen(groupId: groupId),
            ),
          ).then(
            (_) => ref
                .read(groupSchedulesProvider(groupId).notifier)
                .reload(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}.${date.month}.${date.year}';

  String _formatDays(DutyDay days) {
    final List<String> active = [];
    if (days.isMonday == true) active.add('Пн');
    if (days.isTuesday == true) active.add('Вт');
    if (days.isWednesday == true) active.add('Ср');
    if (days.isThursday == true) active.add('Чт');
    if (days.isFriday == true) active.add('Пт');
    if (days.isSaturday == true) active.add('Сб');
    if (days.isSunday == true) active.add('Вс');
    return active.isEmpty ? 'не указаны' : active.join(', ');
  }

    void _deleteSchedule(
    BuildContext context,
    WidgetRef ref,
    int scheduleId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить расписание?'),
        content: const Text('Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final ok = await ref
        .read(groupSchedulesProvider(groupId).notifier)
        .deleteSchedule(scheduleId);

    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось удалить расписание')),
      );
    }
  }
}
