import 'dart:convert';
import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';
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
              Image.asset(
                AssetsManager.imagesAhmed,
                width: AppSize.w(42),
                height: AppSize.h(42),
              ),
              SizedBox(width: AppSize.w(8)),
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
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(height: AppSize.h(2)),
                    Text(
                      overflow: .ellipsis,
                      maxLines: 1,
                      'حارب لأجل حلمك',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: ThemeManager.themeNotifier,
          builder: (context, updatedValue, _) => Material(
            child: InkWell(
              overlayColor: .all(Color(0xFF282828)),
              splashColor: Color(0xFF282828),
              borderRadius: .circular(50),
              onTap: () async {
                await ThemeManager.toggleTheme();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: .all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: .circle,
                ),
                child: Center(
                  child: Icon(
                    updatedValue == ThemeMode.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: updatedValue == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),

        Material(
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
                  borderRadius: BorderRadius.circular(AppSize.r(20)),
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

              if (confirm != true) return;

              for (var task in widget.tasks) {
                task.isDone = !allDone;
              }

              final prefs = await SharedPreferences.getInstance();
              final jsonTasks = widget.tasks.map((e) => e.toJson()).toList();
              await prefs.setString('tasks', jsonEncode(jsonTasks));

              widget.refreshTasks();

              /// Snackbar
              AnimatedSnackBar.material(
                borderRadius: BorderRadius.circular(AppSize.r(20)),
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
      ],
    );
  }

  Widget _showAcceptDialog(bool allDone, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.r(24)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSize.w(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.w(70),
              height: AppSize.w(70),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: allDone
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
              ),
              child: Icon(
                allDone ? Icons.undo : Icons.done_all,
                size: 36,
                color: allDone ? Colors.red : Colors.green,
              ),
            ),

            SizedBox(height: AppSize.h(16)),

            Text(
              allDone ? "إلغاء تنفيذ جميع المهام" : "تنفيذ جميع المهام",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: AppSize.h(8)),

            Text(
              allDone
                  ? "هل تريد إلغاء حالة جميع المهام؟"
                  : "هل تريد تحديد جميع المهام كمكتملة؟",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(height: AppSize.h(24)),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.r(14)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "إلغاء",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppSize.sp(14),
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: AppSize.w(12)),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allDone
                          ? Color(0xFFFF4444)
                          : Colors.green.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.r(14)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "تأكيد",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppSize.sp(14),
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
