import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';
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
            fontSize: AppSize.sp(22),
            fontWeight: .w500,
          ),
        ),
        SizedBox(width: AppSize.w(2)),
        Center(child: SvgPicture.asset(AssetsManager.imagesWavingHand)),
      ],
    ),
      ],
    );
  }
}
