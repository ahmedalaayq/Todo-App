import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';

class WelcomeAppbar extends StatelessWidget {
  const WelcomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(AssetsManager.imagesTasky),
            SizedBox(width: 16),
            Text(
              'Tasky',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: .w500, fontSize: 28.sp),
            ),
          ],
        );
  }
}