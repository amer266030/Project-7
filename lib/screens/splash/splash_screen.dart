import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_screen.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import '../../managers/auth_mgr.dart';
import '../bottom_nav/bottom_nav_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final authMgr = GetIt.I.get<AuthMgr>();

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: "assets/logo1.gif",
      gifWidth: double.infinity,
      gifHeight: double.infinity,
      nextScreen: (authMgr.authData == null)
          ? const AuthScreen()
          : const BottomNavScreen(),
      duration: const Duration(milliseconds: 1500),
      backgroundColor: C.bg2(context),
      onInit: () async {
        debugPrint("onInit");
      },
      onEnd: () async {
        debugPrint("onEnd 1");
      },
    );
  }
}
