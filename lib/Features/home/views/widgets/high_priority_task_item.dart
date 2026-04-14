import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/home/views/high_priority.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/app_size.dart';

class HighPriorityTaskItem extends StatelessWidget {
  const HighPriorityTaskItem({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MainController>(
      builder: (context, value, child) {
        final highPriorityTasks = value.tasks.reversed
            .where((e) => e.isHighPriority)
            .take(4)
            .toList();
        final controller = context.read<MainController>();

        return Container(
          padding: .all(8),
          decoration: BoxDecoration(
            borderRadius: .circular(AppSize.r(20)),
            color: theme.colorScheme.primaryContainer,
            border: theme.brightness == .light
                ? Border.all(color: Color(0xFFD1DAD6), width: AppSize.w(1))
                : null,
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Color(0xFF15B86C),
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  ...highPriorityTasks.map(
                    (element) => InkWell(
                      onTap: () {
                        controller.checkTask(element, !element.isDone);
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: element.isDone,
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF15B86C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.r(4)),
                            ),
                            onChanged: (value) =>
                                controller.checkTask(element, !element.isDone),
                          ),
                          Text(
                            element.taskName,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              decoration: element.isDone ? .lineThrough : null,
                              fontSize: AppSize.sp(14),
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
                  await context.push(ChangeNotifierProvider.value(
                    value: MainController()..loadTasks(),
                    child: HighPriority()));
                  controller.loadTasks();
                },
                child: Container(
                  padding: .all(AppSize.sp(16)),
                  width: AppSize.w(48),
                  height: AppSize.h(48),
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: theme.colorScheme.primaryContainer,
                    border: Border.all(
                      color: Color(0xFFD1DAD6),
                      width: AppSize.w(1.0),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetsManager.imagesIconsArrowForward,
                    width: AppSize.w(24),
                    height: AppSize.h(24),
                    colorFilter: ColorFilter.mode(
                      theme.brightness == .light
                          ? Color(0xFF3A4640)
                          : Color(0xFFC6C6C6),
                      .srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
