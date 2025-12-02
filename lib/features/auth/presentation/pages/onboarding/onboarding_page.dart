import 'package:flutter/material.dart';
import '../name_input_page.dart';
import '../widgets/education_page.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          NameInputPage(controller: controller),
          EducationPage(controller: controller),
        ],
      ),
    );
  }
}

