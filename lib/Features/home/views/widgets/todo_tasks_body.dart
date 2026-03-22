import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/sliver_tasks_list.dart';
import 'package:todo_app/core/utils/app_size.dart';
class TodoTasksBody extends StatelessWidget {
  const TodoTasksBody({
    super.key,
    required this.tasks,
    required this.removeTask,
    required this.checkCard,
  });
  final List<Task> tasks;
  final Function(String id) removeTask;
  final Function(Task task, bool value) checkCard;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (tasks.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'لا يوجد مهمات غير مكتمة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.sp(18),
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: AppSize.h(70), top: 20),
            sliver: SliverTasksList(
              removeTask: removeTask,
              tasks: tasks,
              checkCard: checkCard,
            ),
          ),
      ],
    );
  }
}
