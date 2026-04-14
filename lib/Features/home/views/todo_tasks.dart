import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'widgets/todo_tasks_body.dart';

class TodoTasks extends StatelessWidget {
  const TodoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'المهمات غير المكتملة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: AppSize.sp(20),
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
      ),

      body: TodoTasksBody(
      ),
    );
  }
}
