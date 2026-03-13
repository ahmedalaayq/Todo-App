import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Features/home/models/task.dart';

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
                  fontSize: 18.sp,
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 70.h, top: 20),
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
