import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/edit_task_widget.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/enums/task_item_actions_enum.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/app_size.dart';

import 'task_id_card.dart';

class CustomTaskItem extends StatelessWidget {
  const CustomTaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MainController>();
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () {
          controller.checkTask(task, !task.isDone);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: AppSize.h(8)),
          padding: EdgeInsets.all(AppSize.w(8)),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSize.r(20)),
            border: theme.brightness == Brightness.light
                ? Border.all(
              color: const Color(0xFFD1DAD6),
              width: AppSize.w(1),
            )
                : null,
          ),
          child: Row(
            children: [
              Checkbox(
                value: task.isDone,
                checkColor: Colors.white,
                activeColor: const Color(0xFF15B86C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.r(4)),
                ),
                onChanged: (value) {
                  controller.checkTask(task, value ?? false);
                },
              ),

              SizedBox(width: AppSize.w(8)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskName.capitalizeEachWord,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    if (task.taskDescription.isNotEmpty)
                      Text(
                        task.taskDescription.capitalizeEachWord,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                  ],
                ),
              ),

              PopupMenuButton<TaskItemActionEnum>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) async {
                  switch (value) {
                    case TaskItemActionEnum.check:
                      controller.checkTask(task, !task.isDone);
                      break;

                    case TaskItemActionEnum.edit:
                      await _openEditBottomSheet(context);
                      break;

                    case TaskItemActionEnum.remove:
                      controller.removeTask(context, task.id);
                      break;

                    case TaskItemActionEnum.displayId:
                      _openShowIdDialog(context);
                      break;
                  }
                },
                itemBuilder: (_) {
                  return TaskItemActionEnum.values.map((e) {
                    return PopupMenuItem<TaskItemActionEnum>(
                      value: e,
                      child: Text(
                        e == TaskItemActionEnum.check
                            ? (task.isDone ? 'Unchecked' : 'Checked')
                            : e.name.capitalizeEachWord,
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openShowIdDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: theme.colorScheme.surface,
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

          title: TaskIdTitle(theme: theme),

          content: TaskIDCard(
            theme: theme,
            taskId: task.id,
          ),

          actions: [
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.check_rounded),
              label: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openEditBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return EditTaskWidget(model: task);
      },
    );
  }
}