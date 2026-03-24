// lib/presentation/groups/group_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/group.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/presentation/groups/group_students_tab.dart';
import 'package:frontend/presentation/groups/group_schedules_tab.dart';

class GroupDetailScreen extends ConsumerStatefulWidget {
  final Group group;
  const GroupDetailScreen({super.key, required this.group});

  @override
  ConsumerState<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends ConsumerState<GroupDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary, // явно зададим цвет индикатора
          labelColor: AppColors.primaryDark,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Студенты'),
            Tab(text: 'Расписания'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GroupStudentsTab(groupId: widget.group.id),
          GroupSchedulesTab(groupId: widget.group.id),
        ],
      ),
    );
  }
}
