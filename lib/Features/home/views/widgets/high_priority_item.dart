import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_size.dart';

class HighPriorityItem extends StatefulWidget {
  const HighPriorityItem({
    super.key,
    required this.isBtnActive,
    required this.highPriorityCallBack,
    this.initialHighPriority = false,
  });

  final bool isBtnActive;
  final bool initialHighPriority;
  final Function(bool highPriority) highPriorityCallBack;

  @override
  State<HighPriorityItem> createState() => _HighPriorityItemState();
}

class _HighPriorityItemState extends State<HighPriorityItem> {
  late bool highPriorityTask;

  @override
  void initState() {
    super.initState();
    highPriorityTask = widget.initialHighPriority; 
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          highPriorityTask = !highPriorityTask;
        });
        widget.highPriorityCallBack(highPriorityTask);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(AppSize.w(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.r(16)),
          color: highPriorityTask
              ? const Color(0xFF15B86C).withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Icon(
              highPriorityTask ? Icons.priority_high : Icons.low_priority,
              color: highPriorityTask ? const Color(0xFF15B86C) : Colors.grey,
            ),
            SizedBox(width: AppSize.w(8)),
            Text(
              "High Priority",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: highPriorityTask ? const Color(0xFF15B86C) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}