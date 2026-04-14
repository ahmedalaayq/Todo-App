import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/high_priority_task_item.dart';
import 'package:todo_app/Features/home/views/widgets/sliver_tasks_list.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'achieved_tasks_item.dart';
import 'home_greeting_item.dart';
import 'home_toolbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (BuildContext context, value, Widget? child) {
        final controller = context.read<MainController>();
        final List<Task> highPriority = value.tasks
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
                    HomeToolBar(),
                    SizedBox(height: AppSize.h(16)),
                    const HomeGreetingItem(),
                    SizedBox(height: AppSize.h(16)),
                    value.tasks.isNotEmpty
                        ? AchievedTasksItem(tasks: value.tasks)
                        : SizedBox(),
                    SizedBox(height: AppSize.h(8)),
                    highPriority.isNotEmpty
                        ? HighPriorityTaskItem()
                        : SizedBox.shrink(),
                    SizedBox(height: AppSize.h(24)),
                  ],
                ),
              ),
            ),

            if (value.tasks.isEmpty)
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
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: AppSize.h(70),
                ),
                sliver: SliverTasksList(
                  removeTask: (String? id) {},
                  tasks: value.tasks,
                  checkCard: controller.checkTask,
                  onEdit: controller.loadTasks,
                ),
              ),
          ],
        );
      },
    );
  }
}
