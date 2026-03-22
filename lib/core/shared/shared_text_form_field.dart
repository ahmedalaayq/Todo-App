import 'package:flutter/material.dart';
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
    return TextFormField(
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
    );
  }
}

OutlineInputBorder _buildFieldBorder({Color? color, double? width}) {
  return OutlineInputBorder(
    borderRadius: .circular(16),
    borderSide: BorderSide(
      color: color ?? Color(0xFF15B86C),
      width: width ?? 1.0,
    ),
  );
}
