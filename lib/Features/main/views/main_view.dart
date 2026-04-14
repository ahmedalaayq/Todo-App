import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/views/completed_tasks.dart';
import 'package:todo_app/Features/home/views/home_view.dart';
import 'package:todo_app/Features/home/views/todo_tasks.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/Features/profile/views/profile_view.dart';
import 'widgets/custom_bottom_navbar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (context, value, _) {
        return Scaffold(
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: value.currentIndex,
            onTransition: value.onTransition,
          ),
          body: IndexedStack(
            index: value.currentIndex,
            children: [
              HomeView(),
              TodoTasks(),
              CompletedTasks(),
              const ProfileView(),
            ],
          ),
        );
      },
    );
  }
}
