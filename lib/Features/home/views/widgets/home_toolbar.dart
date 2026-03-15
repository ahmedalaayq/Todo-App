import 'dart:convert';
import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/utils.dart';

class HomeToolBar extends StatefulWidget {
  const HomeToolBar({
    super.key,
    required this.tasks,
    required this.refreshTasks,
  });
  final List<Task> tasks;
  final VoidCallback refreshTasks;

  @override
  State<HomeToolBar> createState() => _HomeToolBarState();
}

class _HomeToolBarState extends State<HomeToolBar> {
  bool welcomeSeen = false;
  bool isLoading = false;
  String userName = 'Guest';

  @override
  void initState() {
    super.initState();
    getUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmptyTasks = widget.tasks.isEmpty;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(AssetsManager.imagesAhmed, width: 42.w, height: 42.h),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: .scaleDown,
                      child: Text(
                        overflow: .ellipsis,
                        maxLines: 1,
                        '${setGreetingMessage12Hour()}, ${userName.capitalizeEachWord}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontFamily: GoogleFonts.cairo().fontFamily,

                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      overflow: .ellipsis,
                      maxLines: 1,
                      'حارب لأجل حلمك',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
            overlayColor: .all(Color(0xFF282828)),
            splashColor: Color(0xFF282828),
            borderRadius: .circular(50),
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: .all(8),
              decoration: BoxDecoration(
                color: Color(0xFF282828),
                shape: .circle,
              ),
              child: SvgPicture.asset(AssetsManager.imagesSun),
            ),
          ),
        ),

        AbsorbPointer(
          absorbing: isLoading,
          child: Material(
            child: InkWell(
              overlayColor: .all(Color(0xFF282828)),
              splashColor: Color(0xFF282828),
              borderRadius: .circular(50),
              onTap: () async {
                isLoading = true;
                setState(() {});
                if (isEmptyTasks) {
                  isLoading = false;
                  return AnimatedSnackBar.material(
                    borderRadius: BorderRadius.circular(20.r),
                    animationDuration: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 3000),
                    animationCurve: Curves.easeInOut,
                    mobileSnackBarPosition: MobileSnackBarPosition.top,
                    'تعذر تنفيذ الإجراء تأكد من اضافة المهام قبل المحاولة',
                    type: AnimatedSnackBarType.error,
                  ).show(context);
                }
                setState(() {});

                final allDone = widget.tasks.every((e) => e.isDone);

                final confirm = await showDialog<bool>(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _showAcceptDialog(allDone, context);
                  },
                );

                /// لو المستخدم ضغط إلغاء
                if (confirm != true) return;

                /// تنفيذ العملية
                for (var task in widget.tasks) {
                  task.isDone = !allDone;
                }

                final prefs = await SharedPreferences.getInstance();
                final jsonTasks = widget.tasks.map((e) => e.toJson()).toList();
                await prefs.setString('tasks', jsonEncode(jsonTasks));

                widget.refreshTasks();

                /// Snackbar
                AnimatedSnackBar.material(
                  borderRadius: BorderRadius.circular(20.r),
                  animationDuration: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 3000),
                  animationCurve: Curves.easeInOut,
                  mobileSnackBarPosition: MobileSnackBarPosition.top,
                  !allDone
                      ? 'تم تنفيذ جميع المهمات'
                      : 'تم الغاء تنفيذ جميع المهمات',
                  type: !allDone
                      ? AnimatedSnackBarType.success
                      : AnimatedSnackBarType.error,
                ).show(context);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: .all(4),
                decoration: BoxDecoration(
                  color: isEmptyTasks == true
                      ? Color(0xFFFF4444)
                      : Color(0xFF15B86C),

                  shape: .circle,
                ),
                child: Icon(
                  isEmptyTasks
                      ? Icons.error_outline
                      : !widget.tasks.every((e) => e.isDone)
                      ? Icons.check_circle_outline
                      : Icons.check_circle,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showAcceptDialog(bool allDone, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: allDone
                    ? Colors.red.withOpacity(.1)
                    : Colors.green.withOpacity(.1),
              ),
              child: Icon(
                allDone ? Icons.undo : Icons.done_all,
                size: 36,
                color: allDone ? Colors.red : Colors.green,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              allDone ? "إلغاء تنفيذ جميع المهام" : "تنفيذ جميع المهام",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            Text(
              allDone
                  ? "هل تريد إلغاء حالة جميع المهام؟"
                  : "هل تريد تحديد جميع المهام كمكتملة؟",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "إلغاء",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allDone
                          ? Color(0xFFFF4444)
                          : Colors.green.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "تأكيد",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      welcomeSeen = prefs.getBool('welcome') ?? false;
      userName = prefs.getString('username') ?? "";
      log('userName: $userName');
      log('welcomeSeen: $welcomeSeen');
    });
  }
}
