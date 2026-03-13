import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/high_priority.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/theme/app_fonts.dart';

class HighPriorityTaskItem extends StatelessWidget {
  const HighPriorityTaskItem({
    super.key,
    required this.tasks,
    required this.onCheckTask,
    required this.removeTask,
    required this.refreshTasks,
  });
  final List<Task> tasks;
  final Function(bool? value, Task task) onCheckTask;
  final Function(String id) removeTask;
  final VoidCallback refreshTasks;

  @override
  Widget build(BuildContext context) {
    final highPriorityTasks = tasks.reversed
        .where((e) => e.isHighPriority)
        .take(4)
        .toList();
    return Container(
      padding: .all(8),
      decoration: BoxDecoration(
        borderRadius: .circular(20.r),
        color: Color(0xFF282828),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .end,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'المهمات ذات الأولوية القصوى',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Color(0xFF15B86C),
                    fontWeight: .bold,
                  ),
                ),
              ),
              ...highPriorityTasks.map(
                (e) => InkWell(
                  onTap: () {
                    onCheckTask(!(e.isDone), e);
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: e.isDone,
                        checkColor: Colors.white,
                        activeColor: const Color(0xFF15B86C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        onChanged: (value) => onCheckTask(value, e),
                      ),
                      Text(
                        e.taskName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: .bold,
                              fontFamily: AppFonts.cairoFontFamily,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    
          InkWell(
            splashFactory: NoSplash.splashFactory,
            overlayColor: .all(Colors.transparent),
            onTap: () async {
              await context.push(
                HighPriority(
                  highPriorityTasks: tasks.where((e)=> e.isHighPriority).toList(),
                  removeTask: removeTask,
                  checkCard: (Task task, bool value) {
                    onCheckTask(value, task);
                  },
                ),
              );
              refreshTasks;
            },
            child: Container(
              padding: .all(17.sp),
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: .circle,
                color: Color(0xFF282828),
                border: Border.all(color: Color(0xFF6E6E6E), width: 1.0.w),
              ),
              child: SvgPicture.asset(
                AssetsManager.imagesIconsArrowForward,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
