import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Features/home/models/task.dart';

class AchievedTasksItem extends StatefulWidget {
  const AchievedTasksItem({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  State<AchievedTasksItem> createState() => _AchievedTasksItemState();
}

class _AchievedTasksItemState extends State<AchievedTasksItem> {
  double value = 0.0;

  Color getValueColor() {
    if (value >= 0.8) {
      return const Color(0xFF22C55E);
    }
    if (value >= 0.6) {
      return const Color(0xFFFACC15);
    }
    if (value >= 0.4) {
      return const Color(0xFFFB923C);
    }
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    final doneTasks = widget.tasks.where((e) => e.isDone == true).length;
    final totalTasks = widget.tasks.length;

    if (totalTasks != 0) {
      value = doneTasks / totalTasks;
    }
    return Container(
      padding: .all(12),
      decoration: BoxDecoration(
        borderRadius: .circular(20.r),
        color: Color(0xFF282828),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'المهمات المنجزة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontWeight: .bold
                  ),
                ),
                Text(
                  '$doneTasks من $totalTasks منجزة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    color: Color(0xFFC6C6C6),
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontWeight: .w500
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade700,
                    valueColor: AlwaysStoppedAnimation(getValueColor()),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  "${(value * 100).toInt()}%",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
