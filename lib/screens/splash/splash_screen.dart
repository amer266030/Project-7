import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/model/enums/theme_state.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/app_theme/app_theme_cubit.dart';
import 'package:rive/rive.dart';


import '../../managers/auth_mgr.dart';
import '../bottom_nav/bottom_nav_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final authMgr = GetIt.I.get<AuthMgr>();

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AppThemeCubit>(context).changeTheme(ThemeState.dark);
    return AnimatedSplashScreen(
      splash: const Text('Splash Screen :)'),
      nextScreen: (authMgr.authData == null)
          ? const AuthScreen()
          : const BottomNavScreen(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.white60,
      duration: 2000,
    );
  }
}
