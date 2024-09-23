import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/img_ext.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_screen.dart';

import '../projects/projects_screen.dart';

class BarItems {
  final BuildContext context;

  BarItems(this.context);

  // Now these are instance properties, so context is accessible
  List<Widget> bottomBarPages = [
    const SettingsScreen(),
    const ProjectsScreen(),
    const ProfileScreen(),
  ];

  List<BottomBarItem> get bottomBarItems {
    return [
      BottomBarItem(
        inActiveItem: Icon(
          CupertinoIcons.settings,
          color: Color(0xFFF5F5F7), // Access colors dynamically with context
        ),
        activeItem: Icon(
          CupertinoIcons.settings,
          color: C.primary(context), // Access colors dynamically with context
        ),
      ),
      const BottomBarItem(
        inActiveItem: Image(image: Img.logoWhite, fit: BoxFit.contain),
        activeItem: Image(image: Img.logo, fit: BoxFit.contain),
      ),
      BottomBarItem(
        inActiveItem: Icon(
          CupertinoIcons.person_fill,
          color: Color(0xFFF5F5F7), // Access colors dynamically with context
        ),
        activeItem: Icon(
          CupertinoIcons.person_fill,
          color: C.primary(context), // Access colors dynamically with context
        ),
      ),
    ];
  }
}
