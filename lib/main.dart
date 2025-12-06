import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/router/auth_gate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MovatoApp()));
}

class MovatoApp extends StatelessWidget {
  const MovatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movato',
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
