import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/group.dart';
import 'package:frontend/data/services/api_client.dart';
import 'package:frontend/presentation/auth/auth_provider.dart';
import 'package:frontend/presentation/groups/group_detail_screen.dart';

final groupsProvider = FutureProvider<List<Group>>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  return await apiClient.getGroups();
});

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои группы'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(
              child: Text('У вас ещё нет групп. Создайте первую!'),
            );
          }
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (ctx, i) {
              final group = groups[i];
              return // внутри ListView.builder
              ListTile(
                title: Text(group.name),
                subtitle: group.description != null
                    ? Text(group.description!)
                    : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GroupDetailScreen(group: group),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Ошибка: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateGroupDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateGroupDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Создать группу'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(ctx);
              try {
                await ref
                    .read(apiClientProvider)
                    .createGroup(
                      name,
                      description: descController.text.trim().isNotEmpty
                          ? descController.text.trim()
                          : null,
                    );
                // Обновляем список групп
                ref.invalidate(groupsProvider);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }
}
