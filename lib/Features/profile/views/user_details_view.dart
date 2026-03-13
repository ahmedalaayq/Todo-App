import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/theme/app_fonts.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'معلومات المستخدم',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: .bold,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 24.h),
            Text(
              'اسم المستخدم',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            SharedTextFormField(),
            SizedBox(height: 24.h),
            Text(
              'العبارة التحفيزية',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            SharedTextFormField(maxLines: 5),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        curve: Curves.easeIn,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        duration: Duration(milliseconds: 250),
        child: ElevatedButton.icon(
          icon: Icon(Icons.save),
          onPressed: () {},
          label: Text('حفظ التعديلات'),
        ),
      ),
    );
  }
}
