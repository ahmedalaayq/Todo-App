import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/views/widgets/tasks_list.dart';
import 'package:todo_app/core/utils/app_size.dart';

class HighPriority extends StatelessWidget {
  const HighPriority({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'المهمات ذات الأولوية القصوى',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: .bold,
            fontSize: AppSize.sp(18),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.w(2.0)),
        child: Column(
          children: [
            SizedBox(height: AppSize.h(24)),
            Expanded(
              child: TasksList(
                // onEdit: controller.loadTasks,
                // removeTask:(String? id){},
                // tasks: value.tasks.where((e)=>e.isHighPriority).toList(),
                // checkCard:controller.checkTask
              ),
            ),
          ],
        ),
      ),
    );
  }
}
