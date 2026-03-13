import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/widgets/tasks_list.dart';

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
          ).textTheme.titleLarge?.copyWith(fontWeight: .bold,fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
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
