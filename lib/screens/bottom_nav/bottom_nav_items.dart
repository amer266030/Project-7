import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_screen.dart';

import '../public/public_screen.dart';

enum BarItems { profile, settings, public }

extension BottomNavItems on BarItems {
  Widget screen() {
    switch (this) {
      case BarItems.profile:
        return const ProfileScreen();
      case BarItems.public:
        return const PublicScreen();
      case BarItems.settings:
        return const SettingsScreen();
    }
  }

  BottomNavigationBarItem navItem() {
    switch (this) {
      case BarItems.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          backgroundColor: Colors.transparent,
        );
      case BarItems.public:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded),
          label: 'Public',
          backgroundColor: Colors.transparent,
        );
      case BarItems.settings:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.transparent,
        );
    }
  }
}
