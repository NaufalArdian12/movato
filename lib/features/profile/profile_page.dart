import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../src/core/constants/gaps.dart';
import '../../src/core/theme/app_text_styles.dart';
import '../../src/core/widgets/app_button.dart';
import '../../src/core/widgets/labeled_field.dart';
import '../../src/core/widgets/avatar_widget.dart';
import '../user/user_model.dart';
import '../user/user_service.dart';
import 'package:movato/src/di/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final UserService _service;

  bool _isEdit = false;
  bool _loading = true;
  UserModel? _user;

  final _emailCtrl = TextEditingController();
  final _fullNameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _educationCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    // ambil service dari provider
    _service = ref.read(userServiceProvider);
    await _loadUser();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _fullNameCtrl.dispose();
    _usernameCtrl.dispose();
    _educationCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    try {
      final u = await _service.getMe();

      setState(() {
        _user = u;
        _loading = false;

        _emailCtrl.text = u.email;
        _fullNameCtrl.text = u.name;

        // Tidak ada username di model → generate
        _usernameCtrl.text = u.name.replaceAll(" ", "").toLowerCase();

        // Tidak ada education di model → placeholder
        _educationCtrl.text = "Elementary School Grade 1";
      });
    } catch (e) {
      debugPrint("Error loading user: $e");
      setState(() => _loading = false);
    }
  }

  InputDecoration _dec({Widget? suffix}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF4A35B0)),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Failed to load user data."),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text("Profile Details", style: AppTextStyles.h2),
            Gaps.v8,
            Text("Edit your profile details here",
                style: AppTextStyles.subtitle),
            Gaps.v24,
            AvatarWidget(imageUrl: _user!.avatarUrl, size: 120),
            Gaps.v16,
            SizedBox(
              width: 140,
              child: AppButton(
                text: _isEdit ? "Save" : "Edit",
                onPressed: () {
                  setState(() => _isEdit = !_isEdit);
                },
              ),
            ),
            Gaps.v32,

            LabeledField(
              label: "Email Address",
              child: TextField(
                controller: _emailCtrl,
                readOnly: true,
                decoration: _dec(),
              ),
            ),
            Gaps.v16,
            LabeledField(
              label: "Username",
              child: TextField(
                controller: _usernameCtrl,
                readOnly: !_isEdit,
                decoration: _dec(),
              ),
            ),
            Gaps.v16,
            LabeledField(
              label: "Full Name",
              child: TextField(
                controller: _fullNameCtrl,
                readOnly: !_isEdit,
                decoration: _dec(),
              ),
            ),
            Gaps.v16,
            LabeledField(
              label: "Education",
              child: TextField(
                controller: _educationCtrl,
                readOnly: !_isEdit,
                decoration: _dec(
                  suffix: _isEdit ? const Icon(Icons.arrow_drop_down) : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
