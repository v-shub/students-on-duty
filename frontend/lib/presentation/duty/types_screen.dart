import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_type.dart';
import 'package:frontend/presentation/duty/types_provider.dart';

class DutyTypesScreen extends ConsumerWidget {
  const DutyTypesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typesAsync = ref.watch(dutyTypeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Типы дежурств')),
      body: typesAsync.when(
        data: (types) {
          // Разделим системные и пользовательские
          final systemTypes = types
              .where((t) => t.id <= 10)
              .toList(); // пример: системные имеют id <= 10
          final userTypes = types.where((t) => t.id > 10).toList();

          return ListView(
            children: [
              if (systemTypes.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Системные',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...systemTypes.map(
                  (type) => _buildTypeTile(context, ref, type, isSystem: true),
                ),
              ],
              if (userTypes.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Мои типы',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...userTypes.map(
                  (type) => _buildTypeTile(context, ref, type, isSystem: false),
                ),
              ],
              if (types.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('Нет типов дежурств'),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Ошибка: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateEditDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTypeTile(
    BuildContext context,
    WidgetRef ref,
    DutyType type, {
    required bool isSystem,
  }) {
    return ListTile(
      title: Text(type.name),
      subtitle: type.description != null ? Text(type.description!) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${type.defaultScore} очков'),
          if (!isSystem) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showCreateEditDialog(context, ref, type: type),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteType(context, ref, type.id),
            ),
          ],
        ],
      ),
    );
  }

  void _showCreateEditDialog(
    BuildContext context,
    WidgetRef ref, {
    DutyType? type,
  }) {
    final nameController = TextEditingController(text: type?.name ?? '');
    final descController = TextEditingController(text: type?.description ?? '');
    final scoreController = TextEditingController(
      text: type?.defaultScore.toString() ?? '1',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(type == null ? 'Создать тип' : 'Редактировать тип'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите название' : null,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              TextFormField(
                controller: scoreController,
                decoration: const InputDecoration(
                  labelText: 'Очки по умолчанию',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Введите очки';
                  if (int.tryParse(v) == null) return 'Введите число';
                  return null;
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
              final name = nameController.text.trim();
              final desc = descController.text.trim().isEmpty
                  ? null
                  : descController.text.trim();
              final score = int.parse(scoreController.text.trim());

              bool success;
              if (type == null) {
                success = await ref
                    .read(dutyTypeProvider.notifier)
                    .createType(name, score, description: desc);
              } else {
                success = await ref
                    .read(dutyTypeProvider.notifier)
                    .updateType(type.id, name, score, description: desc);
              }

              Navigator.pop(ctx);
              if (!success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ошибка сохранения')),
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _deleteType(BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить тип?'),
        content: const Text('Вы уверены? Это действие нельзя отменить.'),
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

    final success = await ref.read(dutyTypeProvider.notifier).deleteType(id);
    if (!success && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Не удалось удалить тип')));
    }
  }
}
