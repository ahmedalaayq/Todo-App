import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'custom_task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({
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
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: .symmetric(horizontal: 8),
          child: CustomTaskItem(
            removeTask: removeTask,
            task: tasks[index],
            index: index,
            checkCard: checkCard,
          ),
        );
      },
      itemCount: tasks.length,
    );
  }
}
