import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/model/enums/theme_state.dart';
import 'package:tuwaiq_project_pulse/screens/settings/app_theme/app_theme_cubit.dart';
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
    return BlocProvider(
      create: (context) => AppThemeCubit()..changeTheme(ThemeState.initial),
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          if (state is AppLightThemeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: SplashScreen(),
            );
          } else if (state is AppDarkThemeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: SplashScreen(),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

/*
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
*/