import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'high_priority_item.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  bool highPriorityTask = false;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  bool isBtnActive = false;
  List<Task> tasksList = [];
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _taskNameController.addListener(validateFields);
    _taskDescriptionController.addListener(validateFields);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  void validateFields() {
    setState(() {
      isBtnActive =
          _taskNameController.text.trim().isNotEmpty ||
          _taskDescriptionController.text.trim().isNotEmpty;
    });
  }

  Future<void> _saveTask() async {
    if ((_formKey.currentState?.validate() ?? false)) {
      final task = Task(
        taskName: _taskNameController.text.trim(),
        taskDescription: _taskDescriptionController.text.trim(),
        isDone: false,
        isHighPriority: highPriorityTask,
      );

      final pref = await SharedPreferences.getInstance();
      // load prev tasks
      final String? taskJson = pref.getString('tasks');
      setState(() {
        if (taskJson != null) {
          final taskListJson = jsonDecode(taskJson) as List<dynamic>;
          tasksList = taskListJson.map((e) => Task.fromJson(e)).toList();
        }

        // save task
        tasksList.add(task);
        // encode
        // log('tasksList Before Encode: $tasksList');
        final List<dynamic> tasksListEncoder = tasksList
            .map((e) => e.toJson())
            .toList();
        log('tasksList After Encode: $tasksListEncoder');
        final taskEncode = jsonEncode(tasksListEncoder);
        // log('tasksList After jsonEncode: $taskEncode');
        // log('---------------------------------------\n');
        pref.setString('tasks', taskEncode);

        if (!mounted) return;
        Navigator.pop(context, true);
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مهمة جديدة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.w(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize.h(20)),
                Text(
                  'عنوان المهمة',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SharedTextFormField(
                  controller: _taskNameController,
                  hintText: 'Finish UI design for login screen',
                ),
                SizedBox(height: AppSize.h(20)),
                Text(
                  'وصف المهمة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SharedTextFormField(
                  enableValidator: false,
                  controller: _taskDescriptionController,
                  hintText:
                      'Finish onboarding UI and hand off to devs by Thursday.',
                  maxLines: 5,
                ),
                SizedBox(height: AppSize.h(20)),
                HighPriorityItem(
                  isBtnActive: isBtnActive,
                  highPriorityCallBack: (highPriority) {
                    setState(() {
                      highPriorityTask = highPriority ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(
          left: AppSize.w(16),
          right: AppSize.w(16),
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? AppSize.h(20)
              : MediaQuery.of(context).viewInsets.bottom + AppSize.h(12),
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: SafeArea(
            child: ElevatedButton.icon(
              onPressed: isBtnActive ? _saveTask : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF15B86C),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, AppSize.h(45)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.r(50)),
                ),
                elevation: 0,
              ),
              icon: Icon(Icons.add, size: AppSize.sp(18)),
              label: Text(
                'Add Task'.capitalizeEachWord,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: .bold,
                ),
              ),
            ),
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: isBtnActive
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
