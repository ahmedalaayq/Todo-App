import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'achieved_tasks_item.dart';
import 'home_greeting_item.dart';
import 'home_toolbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          HomeToolBar(),
          SizedBox(height: 16.h),
          HomeGreetingItem(),
          SizedBox(height: 16.h),
          AchievedTasksItem(),
        ],
      ),
    );
  }
}
