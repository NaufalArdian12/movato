import 'package:flutter/material.dart';
import 'package:movato/features/dashboard/dashboard_page.dart';

class OnboardingController {
  final PageController pageController = PageController();

  String fullName = "";
  String educationLevel = "Elementary School Grade 1";

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void finishOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }
}
