import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/data/models/duty_event.dart';
import 'package:frontend/presentation/home/today_duty_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Текущий месяц для навигации по календарю
  late DateTime _calendarMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _calendarMonth = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final dutyAsync = ref.watch(todayDutyProvider);
    final notifier = ref.read(todayDutyProvider.notifier);
    final selectedDate = dutyAsync.hasValue || dutyAsync.isLoading || dutyAsync.hasError
        ? ref.read(todayDutyProvider.notifier).date
        : DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Дежурства'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.reload(),
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Мини-календарь ──────────────────────────────────────────
          _CalendarSection(
            selectedDate: selectedDate,
            calendarMonth: _calendarMonth,
            events: dutyAsync.value ?? [],
            onDateSelected: (date) => notifier.selectDate(date),
            onMonthChanged: (month) => setState(() => _calendarMonth = month),
          ),
          const Divider(height: 1),
          // ── Заголовок списка ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.today, size: 18, color: AppColors.primaryDark),
                const SizedBox(width: 6),
                Text(
                  _formatDateLabel(selectedDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                dutyAsync.when(
                  data: (events) => Text(
                    '${events.length} событий',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          // ── Список дежурств на день ──────────────────────────────────
          Expanded(
            child: dutyAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                    const SizedBox(height: 12),
                    Text('Ошибка загрузки: $e',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => notifier.reload(),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
              data: (events) {
                if (events.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_available,
                            size: 56, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(
                          'Нет дежурств на ${_formatDateLabel(selectedDate)}',
                          style: const TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => notifier.reload(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: events.length,
                    itemBuilder: (ctx, i) =>
                        _DutyEventCard(info: events[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) return 'Сегодня';
    if (date == tomorrow) return 'Завтра';
    if (date == yesterday) return 'Вчера';

    const months = [
      '', 'янв', 'фев', 'мар', 'апр', 'май', 'июн',
      'июл', 'авг', 'сен', 'окт', 'ноя', 'дек',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Виджет мини-календаря
// ─────────────────────────────────────────────────────────────────────────────

class _CalendarSection extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime calendarMonth;
  final List<DutyEventInfo> events;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onMonthChanged;

  const _CalendarSection({
    required this.selectedDate,
    required this.calendarMonth,
    required this.events,
    required this.onDateSelected,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Набор дат с событиями для отметки на календаре
    final datesWithEvents = events
        .map((e) {
          final d = e.event.dutyDate.toLocal();
          return DateTime(d.year, d.month, d.day);
        })
        .toSet();

    final daysInMonth =
        DateUtils.getDaysInMonth(calendarMonth.year, calendarMonth.month);
    // День недели первого числа месяца (1=Пн..7=Вс)
    final firstWeekday =
        DateTime(calendarMonth.year, calendarMonth.month, 1).weekday;

    const monthNames = [
      '', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Навигация по месяцам
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => onMonthChanged(DateTime(
                  calendarMonth.year,
                  calendarMonth.month - 1,
                )),
              ),
              Expanded(
                child: Text(
                  '${monthNames[calendarMonth.month]} ${calendarMonth.year}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => onMonthChanged(DateTime(
                  calendarMonth.year,
                  calendarMonth.month + 1,
                )),
              ),
            ],
          ),
        ),
        // Заголовки дней недели
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: const [
              _WeekDayLabel('Пн'),
              _WeekDayLabel('Вт'),
              _WeekDayLabel('Ср'),
              _WeekDayLabel('Чт'),
              _WeekDayLabel('Пт'),
              _WeekDayLabel('Сб'),
              _WeekDayLabel('Вс'),
            ],
          ),
        ),
        // Сетка дней
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: daysInMonth + (firstWeekday - 1),
            itemBuilder: (ctx, index) {
              // Пустые ячейки до первого числа
              if (index < firstWeekday - 1) return const SizedBox.shrink();
              final day = index - (firstWeekday - 1) + 1;
              final cellDate =
                  DateTime(calendarMonth.year, calendarMonth.month, day);
              final isSelected = cellDate == selectedDate;
              final hasEvents = datesWithEvents.contains(cellDate);
              final isToday = cellDate ==
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day);

              return GestureDetector(
                onTap: () => onDateSelected(cellDate),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : isToday
                            ? AppColors.primaryLight.withOpacity(0.4)
                            : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isToday && !isSelected
                        ? Border.all(color: AppColors.primaryDark, width: 1.5)
                        : null,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? Colors.black : null,
                        ),
                      ),
                      // Индикатор событий
                      if (hasEvents && !isSelected)
                        Positioned(
                          bottom: 3,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryDark,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeekDayLabel extends StatelessWidget {
  final String label;
  const _WeekDayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Карточка события дежурства
// ─────────────────────────────────────────────────────────────────────────────

class _DutyEventCard extends ConsumerWidget {
  final DutyEventInfo info;
  const _DutyEventCard({required this.info});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = info.event.status;
    final statusColor = _statusColor(status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.15),
          child: Icon(_statusIcon(status), color: statusColor, size: 22),
        ),
        title: Text(
          info.student.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info.dutyType != null)
              Text(info.dutyType!.name,
                  style: const TextStyle(fontSize: 12)),
            if (info.group != null)
              Text('Группа: ${info.group!.name}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusText(status),
                    style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (info.event.scoreEarned != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    '+${info.event.scoreEarned} очков',
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ],
        ),
        isThreeLine: true,
        trailing: status == DutyEventStatus.pending
            ? PopupMenuButton<DutyEventStatus>(
                icon: const Icon(Icons.more_vert),
                tooltip: 'Изменить статус',
                onSelected: (newStatus) async {
                  final error = await ref
                      .read(todayDutyProvider.notifier)
                      .updateEventStatus(info.event.id, newStatus);
                  if (error != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: $error')),
                    );
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: DutyEventStatus.completed,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Выполнено'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
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
              )
            : null,
      ),
    );
  }

  Color _statusColor(DutyEventStatus status) {
    switch (status) {
      case DutyEventStatus.pending:
        return AppColors.warning;
      case DutyEventStatus.completed:
        return AppColors.success;
      case DutyEventStatus.cancelled:
        return AppColors.error;
      case DutyEventStatus.reassigned:
        return AppColors.accentBlue;
    }
  }

  IconData _statusIcon(DutyEventStatus status) {
    switch (status) {
      case DutyEventStatus.pending:
        return Icons.schedule;
      case DutyEventStatus.completed:
        return Icons.check_circle;
      case DutyEventStatus.cancelled:
        return Icons.cancel;
      case DutyEventStatus.reassigned:
        return Icons.swap_horiz;
    }
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
}