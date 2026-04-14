import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'high_priority_item.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MainController>();

    return Consumer<MainController>(
      builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('مهمة جديدة')),

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSize.h(20)),

                  const Text('عنوان المهمة'),
                  const SizedBox(height: 8),

                  SharedTextFormField(
                    controller: value.taskNameController,
                    hintText: 'Finish UI design',
                  ),

                  SizedBox(height: AppSize.h(20)),

                  const Text('وصف المهمة'),
                  const SizedBox(height: 8),

                  SharedTextFormField(
                    enableValidator: false,
                    controller: value.taskDescriptionController,
                    maxLines: 5,
                  ),

                  SizedBox(height: AppSize.h(20)),

                  HighPriorityItem(
                    isBtnActive: value.isAddTaskButtonEnabled,
                    highPriorityCallBack: (v) =>
                        controller.toggleHighPriority(v),
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              left: AppSize.w(16),
              right: AppSize.w(16),
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.h(16),
            ),
            child: ElevatedButton.icon(
              onPressed: value.isAddTaskButtonEnabled
                  ? () => controller.submitTask(context)
                  : null,
              icon: const Icon(Icons.add),
              label: Text('Add Task'.capitalizeEachWord),
            ),
          ),
        );
      },
    );
  }
}
