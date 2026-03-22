import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'widgets/todo_tasks_body.dart';

class TodoTasks extends StatelessWidget {
  const TodoTasks({
    super.key,
    required this.todoTasks,
    required this.onCheck,
    required this.loadTasks,
    required this.removeTask,
  });
  final List<Task> todoTasks;
  final Function(Task task, bool value) onCheck;
  final VoidCallback loadTasks;
  final Function(String id) removeTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'المهمات غير المكتملة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: AppSize.sp(20),
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
      ),

      body: TodoTasksBody(
        tasks: todoTasks,
        checkCard: onCheck,
        removeTask: removeTask,
      ),
    );
  }
}
