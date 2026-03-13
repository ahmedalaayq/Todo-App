import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';

class CustomTodoItem extends StatelessWidget {
  const CustomTodoItem({
    super.key,
    required this.task,
    required this.index,
    required this.checkCard,
    required this.removeTask,
  });

  final Task task;
  final int index;
  final Function(Task task, bool value) checkCard;
  final Function(String id) removeTask;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () => checkCard(task, !task.isDone),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isDone,
                      checkColor: Colors.white,
                      activeColor: const Color(0xFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      onChanged: (value) => checkCard(task, value ?? false),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.taskName.capitalizeEachWord,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: task.isDone
                                      ? Colors.grey
                                      : Colors.white,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                ),
                          ),
                          if (task.taskDescription.isNotEmpty)
                            Text(
                              maxLines: 2,
                              overflow: .ellipsis,
                              task.taskDescription.capitalizeEachWord,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: task.isDone
                                        ? Colors.grey
                                        : Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    decoration: task.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontFamily:
                                        GoogleFonts.cairo().fontFamily,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == "check") {
                    checkCard(task, !task.isDone);
                  } else if (value == "remove") {
                    removeTask(task.id);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: "check",
                    child: Text(task.isDone ? "Uncheck" : "Check"),
                  ),
                  const PopupMenuItem(value: "remove", child: Text("Remove")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
