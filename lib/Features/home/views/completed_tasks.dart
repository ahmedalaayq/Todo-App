import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'widgets/completed_tasks_body.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key, required this.completedTasks, required this.onCheck});
  final List<Task> completedTasks;
    final Function(Task task, bool value) onCheck;


  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  List<Task> completedTasks = [];
  @override
  void initState() {
    super.initState();
    completedTasks = widget.completedTasks;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'المهمات المكتملة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
      ),
      body: CompletedTasksBody(
        tasks: widget.completedTasks,
        checkCard: widget.onCheck,
        removeTask: (String id) {},
      ),
    );
  }
}
