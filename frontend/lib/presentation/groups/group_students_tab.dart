// lib/presentation/groups/group_students_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/data/services/api_client.dart';
import 'package:frontend/presentation/students/all_students_provider.dart';

/// Провайдер студентов конкретной группы — данные загружаются из API
class GroupStudentsNotifier extends AsyncNotifier<List<Student>> {
  final int _groupId;

  GroupStudentsNotifier(this._groupId);

  @override
  Future<List<Student>> build() async {
    return await ref.read(apiClientProvider).getGroupStudents(_groupId);
  }

  /// Перезагрузить список студентов группы из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiClientProvider).getGroupStudents(_groupId),
    );
  }

  /// Добавить существующего студента в группу через API
  Future<bool> addStudentToGroup(int studentId) async {
    try {
      await ref
          .read(apiClientProvider)
          .addStudentToGroup(_groupId, studentId);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Удалить студента из группы через API
  Future<bool> removeStudentFromGroup(int studentId) async {
    try {
      await ref
          .read(apiClientProvider)
          .removeStudentFromGroup(_groupId, studentId);
      state = AsyncValue.data(
        (state.value ?? []).where((s) => s.id != studentId).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

final groupStudentsProvider =
    AsyncNotifierProvider.family<GroupStudentsNotifier, List<Student>, int>(
      (arg) => GroupStudentsNotifier(arg),
    );

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
              ),
            ),
          ),
          Expanded(
            child: groupStudentsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Ошибка загрузки студентов: $e')),
              data: (students) {
                final filtered = _applyFilter(students);
                if (filtered.isEmpty) {
                  return const Center(child: Text('Нет студентов в группе'));
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
                              onPressed: () =>
                                  _editStudent(context, student),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _removeStudentFromGroup(
                                    context,
                                    student.id,
                                  ),
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
            decoration: const InputDecoration(labelText: 'Имя студента'),
            validator: (v) =>
                v == null || v.isEmpty ? 'Введите имя' : null,
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

              // Создаём студента через API
              final newStudent = await ref
                  .read(allStudentsProvider.notifier)
                  .createStudent(name);

              if (newStudent == null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Не удалось создать студента'),
                    ),
                  );
                }
                return;
              }

              // Добавляем созданного студента в группу
              final ok = await ref
                  .read(groupStudentsProvider(widget.groupId).notifier)
                  .addStudentToGroup(newStudent.id);

              if (!ok && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Студент создан, но не добавлен в группу'),
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
    final groupStudents =
        ref.read(groupStudentsProvider(widget.groupId)).value ?? [];
    final existingIds = groupStudents.map((s) => s.id).toSet();

    final allStudents = allStudentsAsync.value ?? [];
    final available =
        allStudents.where((s) => !existingIds.contains(s.id)).toList();

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
                  // Добавляем студента в группу через API
                  final ok = await ref
                      .read(
                        groupStudentsProvider(widget.groupId).notifier,
                      )
                      .addStudentToGroup(student.id);

                  if (!ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Не удалось добавить студента в группу'),
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
                  decoration: const InputDecoration(labelText: 'Имя'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Введите имя' : null,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Активен'),
                  value: isActive,
                  onChanged: (val) =>
                      setDialogState(() => isActive = val),
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
                      .read(
                        groupStudentsProvider(widget.groupId).notifier,
                      )
                      .reload();
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Не удалось обновить студента'),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
        ),
      );
    }
  }
}
