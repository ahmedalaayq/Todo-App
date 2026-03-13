import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'custom_todo_item.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({
    super.key,
    required this.removeTask,
    required this.tasks,
    required this.checkCard,
  });

  final Function(String id) removeTask;
  final List<Task> tasks;
  final Function(Task task, bool value) checkCard;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: .symmetric(horizontal: 8),
          child: CustomTodoItem(
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
