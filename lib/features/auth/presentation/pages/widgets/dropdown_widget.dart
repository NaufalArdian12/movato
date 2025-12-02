import 'package:flutter/material.dart';

class DropdownEducation extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DropdownEducation({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Education Level",
      ),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
