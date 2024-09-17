import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_screen.dart';

import '../public/cubit/public_screen.dart';
import '../user_projects/user_projects_screen.dart';

enum BarItems { supervisor, profile, settings, public }

extension BottomNavItems on BarItems {
  Widget screen() {
    switch (this) {
      case BarItems.supervisor:
        return const UserProjectsScreen();
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
      case BarItems.supervisor:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_4_sharp),
          label: 'Supervisor',
          backgroundColor: Colors.transparent,
        );
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
