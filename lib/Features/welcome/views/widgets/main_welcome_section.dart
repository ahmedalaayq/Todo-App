import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';

class MainWelcomeSection extends StatelessWidget {
  const MainWelcomeSection({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Padding(
        padding: const .symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  textAlign: .center,
                  'مرحبا بك في Tasky ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: AppSize.sp(24),
                    fontWeight: .w500,
                    fontFamily: AppFonts.cairoFontFamily,
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(AssetsManager.imagesWavingHand),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'رحلتك في الإنتاجية تبدأ من هنا',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: AppSize.sp(16),
                fontWeight: .w500,
                fontFamily: AppFonts.cairoFontFamily,
              ),
            ),
            SizedBox(height: 24),
            SvgPicture.asset(AssetsManager.imagesPana, width: 240, height: 240),
            SizedBox(height: 28),
            Align(
              alignment: .centerLeft,
              child: Text(
                'الاسم الكامل',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: .w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SharedTextFormField(
              controller: controller,
              hints: [AutofillHints.name, AutofillHints.username],
            ),
          ],
        ),
      ),
    );
  }
}
