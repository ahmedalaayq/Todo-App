import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/utils/app_size.dart';

import 'sliver_tasks_list.dart';

class CompletedTasksBody extends StatelessWidget {
  const CompletedTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MainController, List<Task>>(
      selector: (_, controller) {
        return controller.tasks.where((task) => task.isDone).toList();
      },
      builder:
          (BuildContext context, List<Task> completedTasks, Widget? child) {
            return CustomScrollView(
              slivers: [
                if (completedTasks.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'لا يوجد مهمات مكتملة',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
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
                    sliver: SliverTasksList(tasks: completedTasks),
                  ),
              ],
            );
          },
    );
  }
}
