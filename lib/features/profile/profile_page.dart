import 'package:flutter/material.dart';
import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/widgets/app_button.dart';
import 'package:movato/src/core/widgets/app_text_field.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import 'package:movato/src/core/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final emailController =
      TextEditingController(text: "azkiyahtiarilah@gmail.com");
  final usernameController =
      TextEditingController(text: "azkiyahtiarilah");
  final fullNameController =
      TextEditingController(text: "Azkiya Ihtiarilah");

  String selectedEducation = "Elementary School Grade 3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _header(),
          Expanded(child: _formSection()),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF9C6CFF),
            Color(0xFF6577FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Profile Details",
            style: AppTextStyles.h2.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            "Edit your profile details here",
            style: AppTextStyles.subtitle.copyWith(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 24),

          // avatar
          Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              "assets/images/monster.png",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 16),

          AppButton(
            text: "Edit",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _formSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabeledField(
            label: "Email Address",
            child: AppTextField(controller: emailController),
          ),
          Gaps.v24,

          LabeledField(
            label: "Username",
            child: AppTextField(controller: usernameController),
          ),
          Gaps.v24,

          LabeledField(
            label: "Full Name",
            child: AppTextField(controller: fullNameController),
          ),
          Gaps.v24,

          LabeledField(
            label: "Education",
            child: _educationDropdown(),
          ),
        ],
      ),
    );
  }

  Widget _educationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedEducation,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedEducation = value);
            }
          },
          items: const [
            DropdownMenuItem(
              value: "Elementary School Grade 1",
              child: Text("Elementary School Grade 1"),
            ),
            DropdownMenuItem(
              value: "Elementary School Grade 2",
              child: Text("Elementary School Grade 2"),
            ),
          ],
        ),
      ),
    );
  }
}
