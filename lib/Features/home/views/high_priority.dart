import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/tasks_list.dart';
import 'package:todo_app/core/utils/app_size.dart';

class HighPriority extends StatefulWidget {
  const HighPriority({
    super.key,
    required this.highPriorityTasks,
    required this.removeTask,
    required this.checkCard, 
  });
  final List<Task> highPriorityTasks;
  final Function(String id) removeTask;
  final Function(Task task, bool value) checkCard;

  @override
  State<HighPriority> createState() => _HighPriorityState();
}

class _HighPriorityState extends State<HighPriority> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'المهمات ذات الأولوية القصوى',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: .bold,fontSize: AppSize.sp(18)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.w(2.0)),
        child: Column(
          children: [
            SizedBox(height: AppSize.h(24)),
            Expanded(
              child: TasksList(
                removeTask: widget.removeTask,
                tasks: widget.highPriorityTasks,
                checkCard: (value, task) {
                  widget.checkCard(value, task);
                  setState(() {
                    
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
