import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: AppTextStyles.field,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
      ),
    );
  }
}
