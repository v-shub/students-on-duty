// lib/presentation/groups/group_students_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/groups/group_students_provider.dart';
import 'package:frontend/presentation/students/all_students_provider.dart';

class GroupStudentsTab extends ConsumerStatefulWidget {
  final int groupId;
  const GroupStudentsTab({super.key, required this.groupId});

  @override
  ConsumerState<GroupStudentsTab> createState() => _GroupStudentsTabState();
}

class _GroupStudentsTabState extends ConsumerState<GroupStudentsTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.removeListener(() => setState(() {}));
    _searchController.dispose();
    super.dispose();
  }

  List<Student> _applyFilter(List<Student> students) {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return students;
    return students.where((s) => s.name.toLowerCase().contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final groupStudentsAsync =
        ref.watch(groupStudentsProvider(widget.groupId));

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск студента...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
          Expanded(
            child: groupStudentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, stackTrace) {
                debugPrint('Error loading students: $e');
                debugPrint('StackTrace: $stackTrace');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text('Ошибка загрузки студентов: $e'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(groupStudentsProvider(widget.groupId)
                                  .notifier)
                              .reload();
                        },
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                );
              },
              data: (students) {
                final filtered = _applyFilter(students);
                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text('Нет студентов в группе'),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => _showAddOptions(context),
                          icon: const Icon(Icons.person_add),
                          label: const Text('Добавить студента'),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(groupStudentsProvider(widget.groupId).notifier)
                      .reload(),
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final student = filtered[i];
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          'Очки: ${student.dutyScore}'
                          '${!student.isActive ? ' (неактивен)' : ''}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () => _editStudent(context, student),
                              tooltip: 'Редактировать',
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _removeStudentFromGroup(context, student.id),
                              tooltip: 'Удалить из группы',
                            ),
                          ],
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
        onPressed: () => _showAddOptions(context),
        child: const Icon(Icons.person_add),
        tooltip: 'Добавить студента',
      ),
    );
  }

  // Диалог выбора действия: создать нового или выбрать из списка
  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Создать нового студента'),
              onTap: () {
                Navigator.pop(ctx);
                _createNewStudent(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Выбрать из существующих'),
              onTap: () {
                Navigator.pop(ctx);
                _showExistingStudentsDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Создание нового студента через API, затем добавление в группу
  void _createNewStudent(BuildContext context) {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Новый студент'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Имя студента',
            border: OutlineInputBorder(),
          ),
          validator: (v) => v == null || v.isEmpty ? 'Введите имя' : null,
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
            final name = nameController.text.trim();
            Navigator.pop(ctx);

            // Показываем индикатор загрузки
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Создание студента...'),
                duration: Duration(seconds: 1),
              ),
            );

            // Создаём студента через API
            final newStudent = await ref
                .read(allStudentsProvider.notifier)
                .createStudent(name, groupId: widget.groupId);

            if (!context.mounted) return;

            if (newStudent == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Не удалось создать студента'),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              // Принудительно перезагружаем список студентов группы
              await ref
                  .read(groupStudentsProvider(widget.groupId).notifier)
                  .reload();
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Студент успешно создан и добавлен в группу'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text('Создать'),
        ),
      ],
    ),
  );
}

  // Диалог выбора существующего студента из общего списка
  void _showExistingStudentsDialog(BuildContext context) {
    final allStudentsAsync = ref.read(allStudentsProvider);
    final groupStudents = ref.read(groupStudentsProvider(widget.groupId)).value ?? [];
    final existingIds = groupStudents.map((s) => s.id).toSet();

    final allStudents = allStudentsAsync.value ?? [];
    final available = allStudents.where((s) => !existingIds.contains(s.id)).toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Нет доступных студентов для добавления'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Выберите студента'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: available.length,
            itemBuilder: (ctx, i) {
              final student = available[i];
              return ListTile(
                title: Text(student.name),
                subtitle: Text('Очки: ${student.dutyScore}'),
                onTap: () async {
                  Navigator.pop(ctx);
                  
                  // Показываем индикатор загрузки
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Добавление студента...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  
                  // Добавляем студента в группу через API
                  final ok = await ref
                      .read(groupStudentsProvider(widget.groupId).notifier)
                      .addStudentToGroup(student.id);

                  if (!ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Не удалось добавить студента в группу'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Студент добавлен в группу'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
        ],
      ),
    );
  }

  // Редактирование студента через API
  void _editStudent(BuildContext context, Student student) {
    final nameController = TextEditingController(text: student.name);
    bool isActive = student.isActive;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
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
                  validator: (v) => v == null || v.isEmpty ? 'Введите имя' : null,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Активен'),
                  value: isActive,
                  onChanged: (val) => setDialogState(() => isActive = val),
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

                // Обновляем студента через API
                final ok = await ref
                    .read(allStudentsProvider.notifier)
                    .updateStudent(
                      student.id,
                      name: nameController.text.trim(),
                      isActive: isActive,
                    );

                // Перезагружаем студентов группы чтобы отобразить изменения
                if (ok) {
                  await ref
                      .read(groupStudentsProvider(widget.groupId).notifier)
                      .reload();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Студент обновлён'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Не удалось обновить студента'),
                      backgroundColor: Colors.red,
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

  // Удаление студента из группы через API
  void _removeStudentFromGroup(BuildContext context, int studentId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить студента из группы?'),
        content: const Text(
          'Студент будет удалён из группы, но останется в общем списке.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final ok = await ref
        .read(groupStudentsProvider(widget.groupId).notifier)
        .removeStudentFromGroup(studentId);

    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось удалить студента из группы'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Студент удалён из группы'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}