import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/sliver_tasks_list.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/utils/app_size.dart';

class TodoTasksBody extends StatelessWidget {
  const TodoTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MainController, List<Task>>(
      builder: (BuildContext context, List<Task> tasksList, Widget? child) {
        return CustomScrollView(
          slivers: [
            if (tasksList.isEmpty)
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
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: AppSize.h(70),
                  top: 20,
                ),
                sliver: SliverTasksList(),
              ),
          ],
        );
      },
      selector: (BuildContext context, MainController controller) {
        return controller.tasks;
      },
    );
  }
}
