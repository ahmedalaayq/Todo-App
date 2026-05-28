import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/utils/app_size.dart';

import '../../models/task.dart';
import 'high_priority_item.dart';

class EditTaskWidget extends StatefulWidget {
  const EditTaskWidget({
    super.key,
    required this.model,
  });

  final Task model;

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  late final TextEditingController editTaskController;

  late final TextEditingController editTaskDescriptionController;

  late bool localHighPriority;

  @override
  void initState() {
    super.initState();

    editTaskController = TextEditingController(
      text: widget.model.taskName,
    );

    editTaskDescriptionController = TextEditingController(
      text: widget.model.taskDescription,
    );

    localHighPriority = widget.model.isHighPriority;
  }

  @override
  void dispose() {
    editTaskController.dispose();
    editTaskDescriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .9,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSize.w(16),
              right: AppSize.w(16),
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: AppSize.h(20)),

                SharedTextFormField(
                  controller: editTaskController,
                  hintText: 'Task title',
                ),

                SizedBox(height: AppSize.h(16)),

                SharedTextFormField(
                  controller: editTaskDescriptionController,
                  hintText: 'Task description',
                  maxLines: 4,
                ),

                SizedBox(height: AppSize.h(16)),

                HighPriorityItem(
                  isBtnActive: true,
                  initialHighPriority: localHighPriority,
                  highPriorityCallBack: (value) {
                    setModalState(() {
                      localHighPriority = value;
                    });
                  },
                ),

                SizedBox(height: AppSize.h(20)),

                ElevatedButton(
                  onPressed: () async {
                    await context.read<MainController>().updateTask(
                      oldTask: widget.model,
                      title: editTaskController.text.trim(),
                      description:
                      editTaskDescriptionController.text.trim(),
                      isHighPriority: localHighPriority,
                    );

                    if (!context.mounted) return;

                    Navigator.pop(context, true);
                  },
                  child: const Text("Update Task"),
                ),

                SizedBox(height: AppSize.h(20)),
              ],
            ),
          ),
        );
      },
    );
  }
}