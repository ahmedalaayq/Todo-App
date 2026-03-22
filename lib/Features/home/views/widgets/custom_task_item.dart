import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/app_size.dart';

class CustomTaskItem extends StatelessWidget {
  const CustomTaskItem({
    super.key,
    required this.task,
    required this.index,
    required this.checkCard,
    required this.removeTask,
  });

  final Task task;
  final int index;
  final Function(Task task, bool value) checkCard;
  final Function(String id) removeTask;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () => checkCard(task, !task.isDone),
        child: Container(
          margin: EdgeInsets.only(bottom: AppSize.h(8)),
          padding: EdgeInsets.all(AppSize.w(8)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSize.r(20)),
            border: theme.brightness == .light
                ? Border.all(color: Color(0xFFD1DAD6), width: AppSize.w(1))
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isDone,
                      checkColor: Colors.white,
                      activeColor: const Color(0xFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.r(4)),
                      ),
                      onChanged: (value) => checkCard(task, value ?? false),
                    ),
                    SizedBox(width: AppSize.w(8)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.taskName.capitalizeEachWord,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                          ),
                          if (task.taskDescription.isNotEmpty)
                            Text(
                              maxLines: 2,
                              overflow: .ellipsis,
                              task.taskDescription.capitalizeEachWord,

                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    decoration: task.isDone
                                        ? .lineThrough
                                        : null,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == "check") {
                    checkCard(task, !task.isDone);
                  } else if (value == "remove") {
                    removeTask(task.id);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: "check",
                    child: Text(task.isDone ? "Uncheck" : "Check"),
                  ),
                  const PopupMenuItem(value: "remove", child: Text("Remove")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
