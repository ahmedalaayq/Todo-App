import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';

import '../../models/task.dart';
import 'custom_task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MainController, List<Task>>(
      builder: (BuildContext context, List<Task> value, Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: .symmetric(horizontal: 8),
              child: CustomTaskItem(
                task: value[index],
              ),
            );
          },
          itemCount: value.length,
        );
      },
      selector: (BuildContext p1, MainController controller) {
        return controller.tasks;
      },
    );
  }
}
