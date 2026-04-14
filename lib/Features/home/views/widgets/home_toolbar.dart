import 'dart:convert';
import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'package:todo_app/core/utils/utils.dart';

class HomeToolBar extends StatelessWidget {
  const HomeToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (context, value, child) {
        final bool isEmptyTasks = value.tasks.isEmpty;
        return Row(
          spacing: 8,
          children: [
            Expanded(
              child: Row(
                children: [
                  value.userImagePath.isNotEmpty
                      ? Image.file(
                        fit: .contain,
                          File(value.userImagePath),
                          width: AppSize.w(42),
                          height: AppSize.h(42),
                        )
                      : Image.asset(
                        fit: .contain,
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
                            '${setGreetingMessage12Hour()}, ${value.userName.capitalizeEachWord}',
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
            Consumer<ThemeManager>(
              builder: (context, theme, _) {
                final controller = context.read<ThemeManager>();
                return Material(
                  
                  type: .transparency,
                  child: InkResponse(
                    radius: 28,
                    highlightShape: .circle,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: .all(
                      Colors.transparent
                    ),
                    splashColor: Colors.transparent,
                    borderRadius: .circular(50),
                    onTap: () async {
                      await controller.toggleTheme();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      padding: .all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400
                          ,width: 1.5
                        ),
                        color: Colors.transparent,
                        // color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: .circle,
                      ),
                      child: Center(
                        child: Icon(
                          theme.themeMode == ThemeMode.dark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: theme.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            Material(
              child: InkWell(
                overlayColor: .all(Color(0xFF282828)),
                splashColor: Color(0xFF282828),
                borderRadius: .circular(50),
                onTap: () async {
                  if (isEmptyTasks) {
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

                  final allDone = value.tasks.every((e) => e.isDone);

                  final confirm = await showDialog<bool>(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return _showAcceptDialog(allDone, context);
                    },
                  );

                  if (confirm != true) return;

                  for (var task in value.tasks) {
                    task.isDone = !allDone;
                  }

                  final jsonTasks = value.tasks.map((e) => e.toJson()).toList();
                  await PreferenceManager.setData<String?>(
                    StorageKey.tasks,
                    jsonEncode(jsonTasks),
                  );

                  value.loadTasks();
                  if (!context.mounted) return;

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
                        : !value.tasks.every((e) => e.isDone)
                        ? Icons.check_circle_outline
                        : Icons.check_circle,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
}
