import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
class HomeGreetingItem extends StatelessWidget {
  const HomeGreetingItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'عمل رائع',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontSize: 28, fontWeight: .w500),
        ),
            Row(
      children: [
        Text(
          'لقد انهيت جميع مهماتك ! ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22.sp,
            fontWeight: .w500,
          ),
        ),
        SizedBox(width: 2.w),
        Center(child: SvgPicture.asset(AssetsManager.imagesWavingHand)),
      ],
    ),
      ],
    );
  }
}
