import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/auth_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: AuthScreen());
  }
}
