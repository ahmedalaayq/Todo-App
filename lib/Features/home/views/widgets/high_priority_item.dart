import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: Colors.orange.withValues(alpha: 0.08),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Icon(Icons.priority_high, color: Colors.orange, size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'This task will be added as normal priority.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.orange,
                  fontSize: 13.sp,
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
          widget.highPriorityCallBack(
            highPriorityTask
          );
        });
      },

      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color: highPriorityTask
                  ? const Color(0xFF15B86C).withValues(alpha: 0.15)
                  : const Color(0xFF2C2C2C),
              border: Border.all(
                color: highPriorityTask
                    ? const Color(0xFF15B86C)
                    : Colors.grey.shade700,
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
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'High Priority Task',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: highPriorityTask
                    ? const Color(0xFF15B86C)
                    : Colors.white,
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
