import 'package:flutter/material.dart';
import 'onboarding/onboarding_controller.dart';

class NameInputPage extends StatelessWidget {
  final OnboardingController controller;

  const NameInputPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),

          Center(
            child: Image.asset(
              "assets/images/class4.jpg",
              height: 150,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Complete Your Profile",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            "Let's get to know you better before we start.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 30),

          TextField(
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.fullName = value;
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 244, 246),
              ),
              onPressed: () {
                controller.nextPage();
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
