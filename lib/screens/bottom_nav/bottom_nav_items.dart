import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/img_ext.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_screen.dart';

import '../projects/projects_screen.dart';

class BarItems {
  static List<Widget> bottomBarPages = [
    const SettingsScreen(),
    const ProjectsScreen(),
    const ProfileScreen(),
  ];

  static List<BottomBarItem> bottomBarItems = [
    const BottomBarItem(
      inActiveItem: Icon(
        CupertinoIcons.settings,
        color: C.bg1,
      ),
      activeItem: Icon(CupertinoIcons.settings, color: C.primary),
    ),
    const BottomBarItem(
      inActiveItem: Image(image: Img.logoWhite, fit: BoxFit.contain),
      activeItem: Image(image: Img.logo, fit: BoxFit.contain),
    ),
    const BottomBarItem(
      inActiveItem: Icon(
        CupertinoIcons.person_fill,
        color: C.bg1,
      ),
      activeItem: Icon(CupertinoIcons.person_fill, color: C.primary),
    ),
  ];
}
