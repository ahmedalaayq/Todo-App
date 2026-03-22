import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/high_priority_task_item.dart';
import 'package:todo_app/Features/home/views/widgets/sliver_tasks_list.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'achieved_tasks_item.dart';
import 'home_greeting_item.dart';
import 'home_toolbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.tasks,
    required this.checkCard,
    required this.removeTask,
    required this.refreshTasks,
  });

  final List<Task> tasks;
  final Function(Task task, bool value) checkCard;
  final Function(String id) removeTask;
  final VoidCallback refreshTasks;

  @override
  Widget build(BuildContext context) {
    final List<Task> highPriority = tasks
        .where((e) => e.isHighPriority)
        .toList();
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
                HomeToolBar(tasks: tasks, refreshTasks: refreshTasks),
                SizedBox(height: AppSize.h(16)),
                const HomeGreetingItem(),
                SizedBox(height: AppSize.h(16)),
                tasks.isNotEmpty ? AchievedTasksItem(tasks: tasks) : SizedBox(),
                SizedBox(height:AppSize.h( 8)),
                highPriority.isNotEmpty
                    ? HighPriorityTaskItem(
                        tasks: tasks,
                        onCheckTask: (bool? value, Task task) {
                          checkCard(task, value ?? false);
                        },
                        removeTask: removeTask,
                        refreshTasks: refreshTasks,
                      )
                    : SizedBox.shrink(),
                SizedBox(height: AppSize.h(24)),
              ],
            ),
          ),
        ),

        if (tasks.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'لا يوجد مهمات مضافة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.sp(18),
                  fontFamily: AppFonts.cairoFontFamily,
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: AppSize.h(70)),
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
