import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/views/widgets/add_task_view.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/utils/app_size.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<MainController>(
        builder: (BuildContext context, value, _) {
          return Scaffold(
            body: SafeArea(child: HomeViewBody()),
            floatingActionButton: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF15B86C),
                foregroundColor: Colors.white,
                minimumSize: const Size(164, 45),
              ),
              icon: Icon(Icons.add, size: AppSize.sp(18)),
              label: Text(
                'إضافة مهمة جديدة',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.sp(15),
                  color: Colors.white,

                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              onPressed: () {
                final controller = context.read<MainController>();

                controller.initAddTask();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTaskView()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
