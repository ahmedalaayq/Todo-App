import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/utils/app_size.dart';

class AchievedTasksItem extends StatelessWidget {
  const AchievedTasksItem({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MainController>(
      builder: (BuildContext context, MainController value, Widget? child) {
        final tasksList = value.tasks;
        final controller = context.read<MainController>();
        final doneTasks = tasksList.where((e) => e.isDone == true).length;
        final totalTasks = tasksList.length;
        if (totalTasks != 0) {
          value.indicatorValue = doneTasks / totalTasks;
        }
        return Container(
          padding: .all(12),
          decoration: BoxDecoration(
            borderRadius: .circular(AppSize.r(20)),
            color: Theme.of(context).colorScheme.primaryContainer,
            border: theme.brightness == .light
                ? Border.all(color: Color(0xFFD1DAD6), width: AppSize.w(1))
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'المهمات المنجزة',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(fontWeight: .bold),
                    ),
                    Text(
                      '$doneTasks من $totalTasks منجزة',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontWeight: .bold),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: CircularProgressIndicator(
                        value: value.indicatorValue,
                        strokeWidth: 4,
                        backgroundColor: Colors.grey.shade700,
                        valueColor: AlwaysStoppedAnimation(
                          controller.getIndicatorColor(),
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "${(value.indicatorValue * 100).toInt()}%",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontWeight: .bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
