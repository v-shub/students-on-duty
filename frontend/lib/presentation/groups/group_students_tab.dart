// lib/presentation/groups/group_students_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';
import 'package:frontend/presentation/students/all_students_provider.dart';

// Провайдер для студентов конкретной группы (изначально пустой, будем управлять локально)
final groupStudentsProvider = StateProvider.family<List<Student>, int>((
  ref,
  groupId,
) {
  return [];
});

class GroupStudentsTab extends ConsumerStatefulWidget {
  final int groupId;
  const GroupStudentsTab({super.key, required this.groupId});

  @override
  ConsumerState<GroupStudentsTab> createState() => _GroupStudentsTabState();
}

class _GroupStudentsTabState extends ConsumerState<GroupStudentsTab> {
  final _searchController = TextEditingController();
  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterStudents);
    _searchController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final groupStudents = ref.read(groupStudentsProvider(widget.groupId));
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredStudents = List.from(groupStudents);
    } else {
      _filteredStudents = groupStudents
          .where((s) => s.name.toLowerCase().contains(query))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final groupStudents = ref.watch(groupStudentsProvider(widget.groupId));
    final allStudents = ref.watch(allStudentsProvider);

    // Если фильтрованный список не синхронизирован, обновляем его
    if (_filteredStudents.isEmpty && groupStudents.isNotEmpty) {
      _filteredStudents = List.from(groupStudents);
    }

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
            child: _filteredStudents.isEmpty
                ? const Center(child: Text('Нет студентов в группе'))
                : RefreshIndicator(
                    onRefresh: () async {
                      // При "обновлении" просто сбрасываем фильтр
                      _searchController.clear();
                    },
                    child: ListView.builder(
                      itemCount: _filteredStudents.length,
                      itemBuilder: (ctx, i) {
                        final student = _filteredStudents[i];
                        return ListTile(
                          title: Text(student.name),
                          subtitle: Text(
                            'Очки: ${student.dutyScore} ${!student.isActive ? '(неактивен)' : ''}',
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
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeStudentFromGroup(
                                  context,
                                  student.id,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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

  // Создание нового студента
  void _createNewStudent(BuildContext context) {
    final nameController = TextEditingController();
    final isActive = true;
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
            validator: (v) => v == null || v.isEmpty ? 'Введите имя' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              final name = nameController.text.trim();

              // Генерируем новый ID (в реальном приложении его даст сервер)
              final allStudents = ref.read(allStudentsProvider.notifier);
              final newId =
                  (ref
                      .read(allStudentsProvider)
                      .map((s) => s.id)
                      .fold(0, (max, id) => id > max ? id : max)) +
                  1;

              final newStudent = Student(
                id: newId,
                name: name,
                isActive: isActive,
                dutyScore: 0,
              );

              // Добавляем в общий список
              allStudents.addStudent(newStudent);

              // Добавляем в группу
              ref
                  .read(groupStudentsProvider(widget.groupId).notifier)
                  .update((state) => [...state, newStudent]);

              Navigator.pop(ctx);
              _filterStudents(); // обновить поиск
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  // Диалог выбора существующего студента из общего списка
  void _showExistingStudentsDialog(BuildContext context) {
    final allStudents = ref.read(allStudentsProvider);
    final groupStudents = ref.read(groupStudentsProvider(widget.groupId));
    final existingIds = groupStudents.map((s) => s.id).toSet();

    // Доступны те, кто ещё не в группе
    final available = allStudents
        .where((s) => !existingIds.contains(s.id))
        .toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нет доступных студентов для добавления')),
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
                onTap: () {
                  // Добавляем в группу
                  ref
                      .read(groupStudentsProvider(widget.groupId).notifier)
                      .update((state) => [...state, student]);
                  Navigator.pop(ctx);
                  _filterStudents();
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

  // Редактирование студента
  void _editStudent(BuildContext context, Student student) {
    final nameController = TextEditingController(text: student.name);
    final isActive = student.isActive;
    final scoreController = TextEditingController(
      text: student.dutyScore.toString(),
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Редактировать студента'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (v) => v == null || v.isEmpty ? 'Введите имя' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: scoreController,
                decoration: const InputDecoration(labelText: 'Очки'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return null;
                  if (int.tryParse(v) == null) return 'Введите число';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Активен'),
                value: isActive,
                onChanged:
                    (val) {}, // будет обновлено позже, но для простоты оставим
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
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final updatedStudent = student.copyWith(
                name: nameController.text.trim(),
                dutyScore:
                    int.tryParse(scoreController.text) ?? student.dutyScore,
                // isActive: , если нужно менять активность, нужно добавить состояние
              );

              // Обновляем в общем списке
              ref
                  .read(allStudentsProvider.notifier)
                  .updateStudent(updatedStudent);

              // Обновляем в группе (заменяем студента)
              ref.read(groupStudentsProvider(widget.groupId).notifier).update((
                state,
              ) {
                return state
                    .map((s) => s.id == updatedStudent.id ? updatedStudent : s)
                    .toList();
              });

              Navigator.pop(ctx);
              _filterStudents();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  // Удаление студента из группы
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

    ref.read(groupStudentsProvider(widget.groupId).notifier).update((state) {
      return state.where((s) => s.id != studentId).toList();
    });
    _filterStudents();
  }
}
