import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';

class MainWelcomeSection extends StatelessWidget {
  const MainWelcomeSection({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 90),
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                textAlign: .center,
                'Welcome To Tasky ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: .w500,
                ),
              ),
              SizedBox(width: 8),
              SvgPicture.asset(AssetsManager.imagesWavingHand),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Your productivity journey starts here.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              fontWeight: .w500,
            ),
          ),
          SizedBox(height: 24),
          SvgPicture.asset(AssetsManager.imagesPana, width: 240, height: 240),
          SizedBox(height: 28),
          Align(
            alignment: .centerLeft,
            child: Text(
              'Full Name',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: .w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SharedTextFormField(controller: controller,),
        ],
      ),
    );
  }
}
