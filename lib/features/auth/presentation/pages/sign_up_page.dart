import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/constants/insets.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/utils/validators.dart';
import 'package:movato/src/core/widgets/app_button.dart';
import 'package:movato/src/core/widgets/app_text_field.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import 'package:movato/src/core/widgets/password_field.dart';

import 'package:movato/features/auth/services/auth_service.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailC = TextEditingController();
  final _usernameC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmPasswordC = TextEditingController();
  final _fullNameC = TextEditingController();

  final _authService = AuthService();

  String? _selectedEducation;
  bool _busy = false;

  final _educationOptions = const [
    'Elementary School Grade 1',
    'Elementary School Grade 2',
    'Elementary School Grade 3',
    'Elementary School Grade 4',
    'Elementary School Grade 5',
    'Elementary School Grade 6',
    'Junior High School',
    'Senior High School',
    'College / University',
    'Other',
  ];

  @override
  void dispose() {
    _emailC.dispose();
    _usernameC.dispose();
    _passwordC.dispose();
    _confirmPasswordC.dispose();
    _fullNameC.dispose();
    super.dispose();
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordC.text) {
      return 'Password does not match';
    }
    return null;
  }

  Future<void> _onSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _busy = true);

    try {
      await _authService.signUp(
        email: _emailC.text.trim(),
        username: _usernameC.text.trim(),
        password: _passwordC.text.trim(),
        fullName: _fullNameC.text.trim(),
        education: _selectedEducation,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up success. Please verify your email.'),
        ),
      );

      // TODO: kalau mau, arahkan ke halaman "Verify your email"
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const VerifyEmailPage()),
      // );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, c) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: c.maxHeight - Insets.x12,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Insets.x12 * 2),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Gaps.v24,
                    Text(
                      'Your Profile',
                      style: AppTextStyles.h1,
                    ),
                    Gaps.v8,
                    Text(
                      'Please fill your profile details below',
                      style: AppTextStyles.subtitle,
                    ),
                    Gaps.v24,
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email
                          LabeledField(
                            label: 'Email Address',
                            child: AppTextField(
                              controller: _emailC,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.mail_outlined,
                                size: 20,
                              ),
                              validator: Validators.email,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Username
                          LabeledField(
                            label: 'Username',
                            child: AppTextField(
                              controller: _usernameC,
                              keyboardType: TextInputType.text,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                size: 20,
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          LabeledField(
                            label: 'Password',
                            child: PasswordField(
                              controller: _passwordC,
                              validator: Validators.password,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '*Minimum 8 characters long',
                            style:
                                AppTextStyles.hint.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          LabeledField(
                            label: 'Confirm Password',
                            child: PasswordField(
                              controller: _confirmPasswordC,
                              validator: _confirmPasswordValidator,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Full Name
                          LabeledField(
                            label: 'Full Name',
                            child: AppTextField(
                              controller: _fullNameC,
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(
                                Icons.badge_outlined,
                                size: 20,
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Education + avatar kecil
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: LabeledField(
                                  label: 'Education',
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedEducation,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                    ),
                                    icon: const Icon(Icons.expand_more),
                                    items: _educationOptions
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedEducation = val;
                                      });
                                    },
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Please select education level';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              CircleAvatar(
                                radius: 22,
                                backgroundColor:
                                    AppColors.text.withOpacity(0.08),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Sign Up button
                          AppButton(
                            text: 'Sign Up',
                            isBusy: _busy,
                            onPressed: _onSignUp,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Insets.x10,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.subtitle.copyWith(
                              color: Colors.black87,
                            ),
                            children: [
                              const TextSpan(
                                text: 'already have an account? ',
                              ),
                              TextSpan(
                                text: 'login',
                                style: AppTextStyles.link.copyWith(
                                  color: AppColors.text,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const LoginPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
