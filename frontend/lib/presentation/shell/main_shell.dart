import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/presentation/home/home_screen.dart';
import 'package:frontend/presentation/groups/groups_screen.dart';
import 'package:frontend/presentation/students/students_screen.dart';
import 'package:frontend/presentation/duty/types_screen.dart';
import 'package:frontend/presentation/profile/profile_screen.dart';

/// Нотифайер индекса активной вкладки
class _ShellIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final _shellIndexProvider =
    NotifierProvider<_ShellIndexNotifier, int>(_ShellIndexNotifier.new);

/// Основная оболочка приложения с нижней панелью навигации
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const _screens = [
    HomeScreen(),
    GroupsScreen(),
    StudentsScreen(),
    DutyTypesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_shellIndexProvider);

    return Scaffold(
      // IndexedStack сохраняет состояние каждого экрана при переключении вкладок
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) =>
            ref.read(_shellIndexProvider.notifier).select(index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: AppColors.primary.withOpacity(0.25),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Дежурства',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Группы',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            selectedIcon: Icon(Icons.people),
            label: 'Студенты',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Типы',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
