import 'package:flutter/material.dart';

class SharedTextFormField extends StatelessWidget {
  const SharedTextFormField({super.key, this.hintText, this.validator, this.controller});
  final String? hintText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:
          validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'feild is required';
            }
            return null;
          },
      cursorColor: Color(0xFF15B86C),
      cursorHeight: 16,
      onTapOutside: (state) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: hintText ?? 'e.g Ahmed Alaayq',
        border: _buildFieldBorder(),
        filled: true,
        fillColor: Color(0xFF282828),
        enabledBorder: _buildFieldBorder(color: Colors.transparent),
        focusedBorder: _buildFieldBorder(),
        errorBorder: _buildFieldBorder(),
        focusedErrorBorder: _buildFieldBorder(),
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
