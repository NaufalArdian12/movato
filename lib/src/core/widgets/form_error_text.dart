import 'package:flutter/material.dart';

class FormErrorText extends StatelessWidget {
  const FormErrorText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
