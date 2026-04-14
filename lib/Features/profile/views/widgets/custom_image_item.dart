import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/theme/theme_manager.dart';

class CustomImageItem extends StatelessWidget {
  const CustomImageItem({super.key, required this.pickImage});
  final Future<XFile?> Function(ImageSource source) pickImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildOption(
            context,
            icon: Icons.camera_alt,
            title: 'Camera',
            onTap: () async {
              Navigator.pop(context);
              await pickImage(ImageSource.camera);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildOption(
            context,
            icon: Icons.image,
            title: 'Gallery',
            onTap: () async {
              Navigator.pop(context);
              await pickImage(ImageSource.gallery);
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildOption(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  final theme = Theme.of(context);

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: ThemeManager.isDark
            ? Colors.purple.shade500
            : Colors.purple.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
