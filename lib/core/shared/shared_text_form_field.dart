import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_size.dart';

class SharedTextFormField extends StatelessWidget {
  const SharedTextFormField({
    super.key,
    this.hintText,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.enableValidator = true, this.hints,
  });
  final String? hintText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? enableValidator;
  final List<String>? hints;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: .foreground,
      decoration: BoxDecoration(
        borderRadius: .circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35.w),
        )
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: .bold,fontSize: AppSize.sp(14)),
        autofillHints:hints ,
        maxLines: maxLines,
        controller: controller,
        validator: enableValidator == true
            ? validator ??
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'feild is required';
                    }
                    return null;
                  }
            : null,
        cursorColor: Color(0xFF15B86C),
        cursorHeight: 16,
        onTapOutside: (state) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: hintText ?? 'مثال : أحمد عماد',
        ),
      ),
    );
  }
}


