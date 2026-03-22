import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/utils/app_size.dart';

import 'sliver_tasks_list.dart';

class CompletedTasksBody extends StatelessWidget {
  const CompletedTasksBody({
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
                'لا يوجد مهمات مكتملة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.sp(18),
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(
              left: AppSize.w(8),
              right: AppSize.w(8),
              bottom: AppSize.h(70),
              top: AppSize.h(20),
            ),
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
