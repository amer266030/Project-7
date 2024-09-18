import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_screen.dart';

import '../projects/cubit/projects_screen.dart';
import '../user_projects/user_projects_screen.dart';

enum BarItems { settings, public, profile }

extension BottomNavItems on BarItems {
  Widget screen() {
    switch (this) {
      case BarItems.settings:
        return const SettingsScreen();
      case BarItems.public:
        return const ProjectsScreen();
      case BarItems.profile:
        return const ProfileScreen();
    }
  }

  BottomNavigationBarItem navItem() {
    switch (this) {
      case BarItems.settings:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 32),
          label: '',
          backgroundColor: Colors.transparent,
        );
      case BarItems.public:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.cases_rounded, size: 32),
          label: '',
          backgroundColor: Colors.transparent,
        );
      case BarItems.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 32),
          label: '',
          backgroundColor: Colors.transparent,
        );
    }
  }
}
