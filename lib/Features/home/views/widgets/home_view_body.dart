import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/high_priority_task_item.dart';
import 'package:todo_app/Features/home/views/widgets/sliver_tasks_list.dart';
import 'achieved_tasks_item.dart';
import 'home_greeting_item.dart';
import 'home_toolbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.tasks,
    required this.checkCard,
    required this.removeTask, required this.refreshTasks,
  });

  final List<Task> tasks;
  final Function(Task task, bool value) checkCard;
  final Function(String id) removeTask;
  final VoidCallback refreshTasks;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      cacheExtent: 500.0,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeToolBar(tasks: tasks,refreshTasks: refreshTasks,),
                SizedBox(height: 16.h),
                const HomeGreetingItem(),
                SizedBox(height: 16.h),
                tasks.isNotEmpty ? AchievedTasksItem(tasks: tasks) : SizedBox(),
                SizedBox(height: 8.h),
                HighPriorityTaskItem(
                  tasks: tasks,
                  onCheckTask: (bool? value, Task task) {
                    checkCard(task, value ?? false);
                  },
                  removeTask: removeTask,
                  refreshTasks: refreshTasks,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        if (tasks.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'No Tasks Added',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 70.h),
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
