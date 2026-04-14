import 'package:flutter/material.dart';

class TaskIDCard extends StatelessWidget {
  const TaskIDCard({super.key, required this.theme, required this.taskId});

  final ThemeData theme;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.numbers_rounded, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: SelectableText(
              taskId,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskIdTitle extends StatelessWidget {
  const TaskIdTitle({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.tag_rounded,
            color: theme.colorScheme.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Task ID',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
