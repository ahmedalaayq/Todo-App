import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/router/app_routes.dart' as route;

import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.tasks,
    required this.onCheck,
    required this.loadTasks,
    required this.removeTask,
  });
  final List<Task> tasks;
  final Function(Task task, bool value) onCheck;
  final VoidCallback loadTasks;
  final Function(String id) removeTask;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: HomeViewBody(
            tasks: widget.tasks,
            checkCard: widget.onCheck,
            removeTask: widget.removeTask,
            refreshTasks: widget.loadTasks,
          ),
        ),
        floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF15B86C),
            foregroundColor: Colors.white,
            minimumSize: const Size(164, 45),
          ),
          icon: Icon(Icons.add, size: 18.sp),
          label: Text(
            'إضافة مهمة جديدة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,

              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          onPressed: () async {
            final value = await context.pushNamed(route.AppRoutes.addTaskView);

            if (value == true) {
              widget.loadTasks();
            }
          },
  
        ),
      ),
    );
  }
}
