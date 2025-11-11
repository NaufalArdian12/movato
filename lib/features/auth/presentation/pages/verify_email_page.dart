import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/constants/insets.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/widgets/app_button.dart';

class VerifyEmailPage extends StatelessWidget {
  final String email;
  const VerifyEmailPage({super.key, required this.email});

  void _showVerificationSentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                size: 56,
                color: AppColors.text,
              ),
              Gaps.v16,
              Text(
                'Verification already send!',
                style: AppTextStyles.h1.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Gaps.v8,
              const Text(
                'check your email and spam folder!',
                textAlign: TextAlign.center,
              ),
              Gaps.v24,
              AppButton(
                text: 'Redirect to Gmail',
                onPressed: () {
                  // TODO: url_launcher ke Gmail kalau mau
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Insets.x12 * 2),
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 120,
                height: 120,
              ),
              Gaps.v32,
              Text(
                'Verify your email address',
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              Gaps.v4,
              Text(
                'Thank you for signing up!',
                style: AppTextStyles.subtitle,
              ),
              Gaps.v16,
              Text(
                'Before we get started, we need to make sure that your email address is valid. '
                'Please check your email inbox and click the verification link we have sent you.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle.copyWith(fontSize: 14),
              ),
              Gaps.v16,
              Text(
                email,
                style: AppTextStyles.link.copyWith(
                  color: AppColors.text,
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Send Verification Email',
                onPressed: () => _showVerificationSentDialog(context),
              ),
              Gaps.v12,
              const Text(
                'not receiving email? check your spam folder',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: Insets.x10),
            ],
          ),
        ),
      ),
    );
  }
}
