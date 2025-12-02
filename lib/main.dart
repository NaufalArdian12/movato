import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// SESUAIKAN path ini dengan punyamu, dari screenshot tadi kira-kira:
import 'features/auth/presentation/pages/onboarding/onboarding_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MovatoApp()));
}

class MovatoApp extends StatelessWidget {
  const MovatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movato',
      debugShowCheckedModeBanner: false,
      // 🔥 MULAI dari ONBOARDING, BUKAN AuthGate
      home: OnboardingPage(),
    );
  }
}
