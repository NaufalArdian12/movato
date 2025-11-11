import 'package:flutter/material.dart';

class FormErrorText extends StatelessWidget {
  const FormErrorText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // page padding 16 + extra 16 agar sejajar dengan AppButton yang punya padding internal 16
      padding: const EdgeInsets.only(),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 14,
          color: Colors.red,
          height: 1.2,
        ),
      ),
    );
  }
}
