import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/enums/task_item_actions_enum.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/utils/app_size.dart';

import 'high_priority_item.dart';

class CustomTaskItem extends StatefulWidget {
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
  State<CustomTaskItem> createState() => _CustomTaskItemState();
}

class _CustomTaskItemState extends State<CustomTaskItem> {
  bool isBtnActive = false;
  bool highPriorityTask = false;

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

  void _openEditBottomSheet() {
    _taskNameController.text = widget.task.taskName;
    _taskDescriptionController.text = widget.task.taskDescription;
    highPriorityTask = widget.task.isHighPriority;
    validateFields();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.45,
            maxChildSize: 0.90,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.w(16),
                  vertical: AppSize.h(16),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSize.r(28)),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Center(
                          child: Container(
                            width: AppSize.w(50),
                            height: AppSize.h(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.h(20)),

                        Center(
                          child: Text(
                            textAlign: .center,
                            'Edit Task',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: AppSize.h(24)),

                        Text(
                          'عنوان المهمة',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: AppSize.h(8)),
                        SharedTextFormField(
                          controller: _taskNameController,
                          hintText: 'Finish UI design for login screen',
                        ),

                        SizedBox(height: AppSize.h(20)),

                        Text(
                          'وصف المهمة',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: AppSize.h(8)),
                        SharedTextFormField(
                          controller: _taskDescriptionController,
                          enableValidator: false,
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          maxLines: 5,
                        ),

                        SizedBox(height: AppSize.h(20)),

                        HighPriorityItem(
                          isBtnActive: highPriorityTask,
                          highPriorityCallBack: (value) {
                            setState(() {
                              highPriorityTask = value ?? false;
                            });
                          },
                        ),

                        SizedBox(height: AppSize.h(24)),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isBtnActive
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text('Save Changes'),
                          ),
                        ),

                        SizedBox(height: AppSize.h(12)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () => widget.checkCard(widget.task, !widget.task.isDone),
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
                      value: widget.task.isDone,
                      checkColor: Colors.white,
                      activeColor: const Color(0xFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.r(4)),
                      ),
                      onChanged: (value) =>
                          widget.checkCard(widget.task, value ?? false),
                    ),
                    SizedBox(width: AppSize.w(8)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.taskName.capitalizeEachWord,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  decoration: widget.task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                          ),
                          if (widget.task.taskDescription.isNotEmpty)
                            Text(
                              widget.task.taskDescription.capitalizeEachWord,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    decoration: widget.task.isDone
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
                onSelected: (value) {
                  if (value == TaskItemActionEnum.check) {
                    widget.checkCard(widget.task, !widget.task.isDone);
                  } else if (value == TaskItemActionEnum.remove) {
                    widget.removeTask(widget.task.id);
                  } else {
                    _openEditBottomSheet();
                  }
                },
                itemBuilder: (_) => TaskItemActionEnum.values.map((e) {
                  return PopupMenuItem<TaskItemActionEnum>(
                    value: e,
                    child: Text(
                      e == TaskItemActionEnum.check
                          ? (widget.task.isDone ? 'Unchecked' : 'Checked')
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
  }
}
