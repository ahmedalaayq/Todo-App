import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'custom_task_item.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomTaskItem(task: tasks[index]),
        );
      }, childCount: tasks.length),
    );
  }
}
