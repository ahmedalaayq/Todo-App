import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'custom_task_item.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MainController, List<Task>>(
      builder: (context, tasksList, _) {
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: .symmetric(horizontal: 8),
              child: CustomTaskItem(
                index: index,
              ),
            );
          }, childCount: tasksList.length),
        );
      },
      selector: (BuildContext p1, MainController controller) {
        return controller.tasks;
      },
    );
  }
}
