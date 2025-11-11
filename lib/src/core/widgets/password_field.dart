import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.validator,
    this.decoration,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final void Function(String)? onFieldSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscure,
      style: AppTextStyles.field,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
