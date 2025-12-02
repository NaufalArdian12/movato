import 'package:flutter/material.dart';
import '../onboarding/onboarding_controller.dart';

class EducationPage extends StatelessWidget {
  final OnboardingController controller;

  const EducationPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final grades = [
      "Elementary School Grade 1",
      "Elementary School Grade 2",
      "Elementary School Grade 3",
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(),

          Center(child: Image.asset("assets/images/monster2.png", height: 150)),

          const SizedBox(height: 20),

          const Text(
            "Choose Education Level",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),
          const Text(
            "This helps us personalize your experience.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 30),

          DropdownMenu<String>(
            initialSelection: controller.educationLevel.isEmpty
                ? "Elementary School Grade 1"
                : controller.educationLevel,
            dropdownMenuEntries: grades
                .map((e) => DropdownMenuEntry(value: e, label: e))
                .toList(),
            onSelected: (value) {
              controller.educationLevel = value!;
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                controller.finishOnboarding(context);
              },
              child: const Text("Continue"),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
