import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_size.dart';

class HighPriorityItem extends StatefulWidget {
  const HighPriorityItem({
    super.key,
    required this.isBtnActive,
    required this.highPriorityCallBack,
  });
  final bool isBtnActive;
  final Function(bool? highPriority) highPriorityCallBack;
  @override
  State<HighPriorityItem> createState() => _HighPriorityItemState();
}

class _HighPriorityItemState extends State<HighPriorityItem> {
  bool highPriorityTask = false;
  @override
  Widget build(BuildContext context) {
    if (!widget.isBtnActive) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(top: AppSize.h(12)),
        padding: EdgeInsets.all(AppSize.w(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.r(14)),
          color: Colors.orange.withValues(alpha: 0.08),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.priority_high,
              color: Colors.orange,
              size: AppSize.sp(18),
            ),
            SizedBox(width: AppSize.w(8)),
            Expanded(
              child: Text(
                'سيتم اضافة المهمة بالأولوية العادية',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.orange,
                  fontSize: AppSize.sp(13),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          highPriorityTask = !highPriorityTask;
          widget.highPriorityCallBack(highPriorityTask);
        });
      },

      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.w(10),
              vertical: AppSize.h(10),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.r(18)),
              color: highPriorityTask
                  ? const Color(0xFF15B86C).withValues(alpha: 0.15)
                  : Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                color: highPriorityTask
                    ? const Color(0xFF15B86C)
                    : Theme.of(context).colorScheme.primaryContainer,
                width: 1.5,
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: highPriorityTask
                    ? const Color(0xFF15B86C)
                    : Colors.red.shade700,
              ),
              child: Icon(
                highPriorityTask ? Icons.priority_high : Icons.low_priority,
                color: Colors.white,
                size: AppSize.sp(18),
              ),
            ),
          ),
          SizedBox(width: AppSize.w(12)),
          Expanded(
            child: Text(
              'High Priority Task',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: highPriorityTask
                    ? const Color(0xFF15B86C)
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: highPriorityTask
                ? Icon(
                    Icons.check_circle,
                    key: const ValueKey(true),
                    color: const Color(0xFF15B86C),
                  )
                : Icon(
                    Icons.circle_outlined,
                    key: const ValueKey(false),
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
    );
  }
}
