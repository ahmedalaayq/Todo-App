import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/views/widgets/edit_task_widget.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/enums/task_item_actions_enum.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'task_id_card.dart';

class CustomTaskItem extends StatefulWidget {
  const CustomTaskItem({super.key, required this.index});

  final int index;

  @override
  State<CustomTaskItem> createState() => _CustomTaskItemState();
}

class _CustomTaskItemState extends State<CustomTaskItem> {
  bool isBtnActive = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskNameController.addListener(validateFields);
    _taskDescriptionController.addListener(validateFields);
  }

  void validateFields() {
    setState(() {
      isBtnActive =
          _taskNameController.text.trim().isNotEmpty &&
          _taskDescriptionController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _taskNameController.removeListener(validateFields);
    _taskDescriptionController.removeListener(validateFields);
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MainController>(
      builder: (BuildContext context, MainController value, _) {
        final controller = context.read<MainController>();
        final tasksList = value.tasks;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: () => controller.checkTask(
              tasksList[widget.index],
              !tasksList[widget.index].isDone,
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: AppSize.h(8)),
              padding: EdgeInsets.all(AppSize.w(8)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSize.r(20)),
                border: theme.brightness == Brightness.light
                    ? Border.all(
                        color: const Color(0xFFD1DAD6),
                        width: AppSize.w(1),
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: tasksList[widget.index].isDone,
                          checkColor: Colors.white,
                          activeColor: const Color(0xFF15B86C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.r(4)),
                          ),
                          onChanged: (value) => controller.checkTask(
                            tasksList[widget.index],
                            value ?? false,
                          ),
                        ),
                        SizedBox(width: AppSize.w(8)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasksList[widget.index]
                                    .taskName
                                    .capitalizeEachWord,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      decoration: tasksList[widget.index].isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                              ),
                              if (tasksList[widget.index]
                                  .taskDescription
                                  .isNotEmpty)
                                Text(
                                  tasksList[widget.index]
                                      .taskDescription
                                      .capitalizeEachWord,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        decoration:
                                            tasksList[widget.index].isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                ),
                            ],
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
                          controller.checkTask(
                            tasksList[widget.index],
                            !tasksList[widget.index].isDone,
                          );
                          break;
                        case TaskItemActionEnum.edit:
                          final bool? result = await _openEditBottomSheet(
                            context,
                          );
                          if (result == true) {
                            controller.loadTasks();
                          }
                          break;
                        case TaskItemActionEnum.remove:
                          controller.removeTask(
                            context,
                            tasksList[widget.index].id,
                          );
                          break;
                        case TaskItemActionEnum.displayId:
                          _openShowIdDialog();
                          break;
                      }
                    },
                    itemBuilder: (_) => TaskItemActionEnum.values.map((e) {
                      return PopupMenuItem<TaskItemActionEnum>(
                        value: e,
                        child: Text(
                          e == TaskItemActionEnum.check
                              ? (tasksList[widget.index].isDone
                                    ? 'Unchecked'
                                    : 'Checked')
                              : e.name.capitalizeEachWord,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openShowIdDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = context.read<MainController>();
        final theme = Theme.of(context);

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
            taskId: controller.tasks[widget.index].id,
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.check_rounded),
              label: const Text('Close'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _openEditBottomSheet(BuildContext context) async {
    return showModalBottomSheet<bool?>(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final controller = context.read<MainController>();
        return EditTaskWidget(model: controller.tasks[widget.index]);
      },
    );
  }
}
