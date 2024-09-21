import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/splash/splash_screen.dart';
import 'package:tuwaiq_project_pulse/services/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIContainer.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: const ColorScheme.light(
      //     primary: Colors.deepPurple,
      //     onPrimary: Colors.white,
      //     secondary: Colors.deepPurpleAccent,
      //     onSecondary: Color(0xFFFAFAFA),
      //     surface: Color(0xFFFAFAFA),
      //     onSurface: Colors.black,
      //   ),
      // ),
      // darkTheme: ThemeData(
      //   colorScheme: const ColorScheme.dark(
      //     primary: Colors.deepPurple,
      //     onPrimary: Colors.white,
      //     secondary: Colors.deepPurpleAccent,
      //     onSecondary: Color(0xFFFAFAFA),
      //     surface: Color(0xFFFAFAFA),
      //     onSurface: Colors.black,
      //   ),
      // ),
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
