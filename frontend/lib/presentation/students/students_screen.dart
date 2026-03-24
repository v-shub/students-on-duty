import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/data/models/absence.dart';
import 'package:frontend/data/models/group.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/groups/groups_screen.dart';
import 'package:frontend/presentation/students/all_students_provider.dart';
import 'package:frontend/presentation/students/absences_provider.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(allStudentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Студенты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(allStudentsProvider.notifier).reload(),
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: Column(
        children: [
          // Поиск
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Поиск студента...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ),
          ),
          // Список студентов
          Expanded(
            child: studentsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: AppColors.error),
                    const SizedBox(height: 12),
                    Text('Ошибка: $e', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(allStudentsProvider.notifier).reload(),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
              data: (students) {
                final query = _searchController.text.toLowerCase();
                final filtered = query.isEmpty
                    ? students
                    : students
                        .where((s) =>
                            s.name.toLowerCase().contains(query))
                        .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_outline,
                            size: 56, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(
                          students.isEmpty
                              ? 'Нет студентов.\nСоздайте первого!'
                              : 'Ничего не найдено',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(allStudentsProvider.notifier).reload(),
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) =>
                        _StudentTile(student: filtered[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateStudentDialog(context),
        tooltip: 'Создать студента',
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _showCreateStudentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Group? selectedGroup;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          final groupsAsync = ref.watch(groupsProvider);

          return AlertDialog(
            title: const Text('Новый студент'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Имя студента',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Введите имя' : null,
                  ),
                  const SizedBox(height: 16),
                  groupsAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (e, _) => Text(
                      'Не удалось загрузить группы: $e',
                      style: const TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                    data: (groups) {
                      if (groups.isEmpty) {
                        return const Text(
                          'Нет доступных групп. Сначала создайте группу.',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 12),
                        );
                      }
                      return DropdownButtonFormField<Group>(
                        value: selectedGroup,
                        decoration: const InputDecoration(
                          labelText: 'Группа',
                          border: OutlineInputBorder(),
                        ),
                        items: groups
                            .map((g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(g.name),
                                ))
                            .toList(),
                        onChanged: (g) => setState(() => selectedGroup = g),
                        validator: (_) =>
                            selectedGroup == null ? 'Выберите группу' : null,
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  if (selectedGroup == null) return;
                  Navigator.pop(ctx);
                  final student = await ref
                      .read(allStudentsProvider.notifier)
                      .createStudent(
                        nameController.text.trim(),
                        groupId: selectedGroup!.id,
                      );
                  if (student == null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Не удалось создать студента'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                child: const Text('Создать'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Плитка студента с раскрывающимися деталями
// ─────────────────────────────────────────────────────────────────────────────

class _StudentTile extends ConsumerWidget {
  final Student student;
  const _StudentTile({required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: student.isActive
              ? AppColors.primary.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          child: Text(
            student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  student.isActive ? AppColors.primaryDark : Colors.grey,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: student.isActive ? null : Colors.grey,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, size: 13, color: AppColors.warning),
            const SizedBox(width: 2),
            Text('${student.dutyScore} очков',
                style: const TextStyle(fontSize: 12)),
            if (!student.isActive) ...[
              const SizedBox(width: 8),
              const Text('(неактивен)',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.accentBlue),
              onPressed: () => _showEditDialog(context, ref),
              tooltip: 'Редактировать',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () => _confirmDelete(context, ref),
              tooltip: 'Удалить',
            ),
          ],
        ),
        children: [
          _AbsencesSection(student: student),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: student.name);
    bool isActive = student.isActive;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Редактировать студента'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Имя',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Введите имя' : null,
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Активен'),
                  value: isActive,
                  onChanged: (val) => setState(() => isActive = val),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(ctx);
                final ok = await ref
                    .read(allStudentsProvider.notifier)
                    .updateStudent(
                      student.id,
                      name: nameController.text.trim(),
                      isActive: isActive,
                    );
                if (!ok && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Не удалось обновить студента'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить студента?'),
        content: Text(
          'Студент "${student.name}" будет удалён безвозвратно.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final ok =
        await ref.read(allStudentsProvider.notifier).deleteStudent(student.id);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось удалить студента'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Секция отсутствий студента (внутри ExpansionTile)
// ─────────────────────────────────────────────────────────────────────────────

class _AbsencesSection extends ConsumerWidget {
  final Student student;
  const _AbsencesSection({required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final absencesAsync = ref.watch(studentAbsencesProvider(student.id));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_busy, size: 16, color: AppColors.error),
              const SizedBox(width: 6),
              const Text(
                'Отсутствия',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showCreateAbsenceDialog(context, ref),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Добавить', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
          absencesAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (e, _) => Text('Ошибка: $e',
                style: const TextStyle(color: AppColors.error)),
            data: (absences) {
              if (absences.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Нет зарегистрированных отсутствий',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 13),
                  ),
                );
              }
              return Column(
                children: absences
                    .map((a) => _AbsenceTile(
                          absence: a,
                          studentId: student.id,
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCreateAbsenceDialog(BuildContext context, WidgetRef ref) {
    DateTime dateFrom = DateTime.now();
    DateTime dateTo = DateTime.now();
    final reasonController = TextEditingController();
    bool isApproved = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Отсутствие: ${student.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Дата начала
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today,
                      color: AppColors.primaryDark),
                  title: const Text('С', style: TextStyle(fontSize: 13)),
                  subtitle: Text(_formatDate(dateFrom),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: dateFrom,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (d != null) setState(() => dateFrom = d);
                  },
                ),
                // Дата окончания
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today,
                      color: AppColors.error),
                  title: const Text('По', style: TextStyle(fontSize: 13)),
                  subtitle: Text(_formatDate(dateTo),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: dateTo.isBefore(dateFrom)
                          ? dateFrom
                          : dateTo,
                      firstDate: dateFrom,
                      lastDate: DateTime(2030),
                    );
                    if (d != null) setState(() => dateTo = d);
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Причина (необязательно)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Подтверждено (без штрафа)'),
                  subtitle: Text(
                    isApproved 
                      ? 'Отсутствие одобрено — дежурство будет переназначено без штрафа'
                      : 'Требуется подтверждение — при неодобрении будет штраф',
                    style: const TextStyle(fontSize: 11),
                  ),
                  contentPadding: EdgeInsets.zero,
                  value: isApproved,
                  onChanged: (val) => setState(() => isApproved = val),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (dateTo.isBefore(dateFrom)) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Дата окончания не может быть раньше начала')),
                  );
                  return;
                }
                Navigator.pop(ctx);
                
                // Показываем индикатор загрузки
                final messenger = ScaffoldMessenger.of(context);
                
                final error = await ref
                    .read(studentAbsencesProvider(student.id).notifier)
                    .createAbsence(
                      dateFrom: dateFrom,
                      dateTo: dateTo,
                      reason: reasonController.text.trim().isEmpty
                          ? null
                          : reasonController.text.trim(),
                      isApproved: isApproved,
                    );
                    
                if (error != null && context.mounted) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Ошибка: $error'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                } else if (context.mounted) {
                  // Успешно создано
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        isApproved 
                          ? 'Отсутствие создано и одобрено'
                          : 'Отсутствие создано, ожидает подтверждения',
                      ),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  // Обновляем рейтинг студента в UI
                  ref.read(allStudentsProvider.notifier).reload();
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
}

// ─────────────────────────────────────────────────────────────────────────────
// Плитка одного отсутствия
// ─────────────────────────────────────────────────────────────────────────────

// students_screen.dart - исправленный _AbsenceTile

class _AbsenceTile extends ConsumerWidget {
  final Absence absence;
  final int studentId;
  const _AbsenceTile({required this.absence, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: absence.isApproved
            ? AppColors.success.withOpacity(0.08)
            : AppColors.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: absence.isApproved
              ? AppColors.success.withOpacity(0.4)
              : AppColors.warning.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            absence.isApproved ? Icons.check_circle : Icons.pending,
            size: 16,
            color: absence.isApproved ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_fmt(absence.dateFrom)} — ${_fmt(absence.dateTo)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                if (absence.reason != null)
                  Text(
                    absence.reason!,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary),
                  ),
                Row(
                  children: [
                    Icon(
                      absence.isApproved 
                        ? Icons.verified_outlined 
                        : Icons.pending_outlined,
                      size: 12,
                      color: absence.isApproved 
                        ? AppColors.success 
                        : AppColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      absence.isApproved 
                        ? 'Одобрено (без штрафа)' 
                        : 'Не одобрено',
                      style: TextStyle(
                        fontSize: 11,
                        color: absence.isApproved
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Кнопка изменения статуса одобрения
          IconButton(
            icon: Icon(
              absence.isApproved 
                ? Icons.cancel_outlined 
                : Icons.check_circle_outline,
              size: 20,
              color: absence.isApproved 
                ? AppColors.error 
                : AppColors.success,
            ),
            tooltip: absence.isApproved 
              ? 'Снять одобрение' 
              : 'Одобрить (без штрафа)',
            onPressed: () => _toggleApproval(context, ref),
          ),
          // Кнопка удаления
          IconButton(
            icon: const Icon(Icons.delete_outline,
                size: 18, color: AppColors.error),
            tooltip: 'Удалить',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleApproval(BuildContext context, WidgetRef ref) async {
    final newApprovalStatus = !absence.isApproved;
    final actionText = newApprovalStatus ? 'одобрить' : 'снять одобрение';
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${newApprovalStatus ? 'Одобрить' : 'Снять одобрение'} отсутствие'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Период: ${_fmt(absence.dateFrom)} — ${_fmt(absence.dateTo)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (newApprovalStatus)
              const Text(
                'При одобрении:\n'
                '• Студент НЕ получит штраф\n'
                '• Дежурство будет переназначено другому студенту',
                style: TextStyle(fontSize: 13),
              )
            else
              const Text(
                'При снятии одобрения:\n'
                '• Студент получит штраф\n'
                '• Дежурство будет переназначено повторно',
                style: TextStyle(fontSize: 13),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: newApprovalStatus 
                ? AppColors.success 
                : AppColors.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(actionText),
          ),
        ],
      ),
    );
    
    if (confirm != true) return;
    
    final messenger = ScaffoldMessenger.of(context);
    
    // Показываем индикатор загрузки
    final overlay = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
    Overlay.of(context).insert(overlay);
    
    try {
      final error = await ref
          .read(studentAbsencesProvider(studentId).notifier)
          .updateAbsence(
            absence.id,
            isApproved: newApprovalStatus,
          );
          
      overlay.remove();
      
      if (error != null && context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Ошибка: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              newApprovalStatus 
                ? 'Отсутствие одобрено, штраф не применён'
                : 'Одобрение снято, будет применён штраф',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        
        // Обновляем рейтинг студента в UI
        ref.invalidate(allStudentsProvider);
        
        // Принудительно обновляем список отсутствий
        await ref.read(studentAbsencesProvider(studentId).notifier).reload();
      }
    } catch (e) {
      overlay.remove();
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить отсутствие?'),
        content: Text(
          'Период: ${_fmt(absence.dateFrom)} — ${_fmt(absence.dateTo)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final overlay = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
    Overlay.of(context).insert(overlay);
    
    try {
      final error = await ref
          .read(studentAbsencesProvider(studentId).notifier)
          .deleteAbsence(absence.id);
          
      overlay.remove();
      
      if (error != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (context.mounted) {
        // Обновляем рейтинг студента после удаления отсутствия
        ref.invalidate(allStudentsProvider);
      }
    } catch (e) {
      overlay.remove();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
}