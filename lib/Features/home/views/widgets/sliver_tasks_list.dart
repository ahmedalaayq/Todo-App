import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'custom_task_item.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({
    super.key,
    required this.removeTask,
    required this.tasks,
    required this.checkCard, required this.onEdit,
  });

  final Function(String id) removeTask;
  final List<Task> tasks;
  final Function(Task task, bool value) checkCard;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: .symmetric(horizontal: 8),
          child: CustomTaskItem(
            onEdit: onEdit,
            removeTask: removeTask,
            task: tasks[index],
            index: index,
            checkCard: checkCard,
          ),
        );
      }, childCount: tasks.length),
    );
  }
}
