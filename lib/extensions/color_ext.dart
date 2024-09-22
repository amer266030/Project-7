import 'package:flutter/material.dart';

// Color(0xFF4F29B7)
extension C on Colors {

  static Color primary(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFF4F29B7) : const Color(0xFF4F29B7);
  }

  static Color secondary(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFFE3D8FF) : const Color(0xFFE3D8FF);
  }

  static Color secondaryWOpacity(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xB3E3D8FF) : const Color(0xB3E3D8FF);
  }

  static Color bg1(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFFF5F5F7) : const Color(0xFFF5F5F7);
  }

  static Color bg2(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFFF9FAFB) : const Color(0xFFF9FAFB);
  }

  static Color bg3(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFF4A0EB0) : const Color(0xFF4A0EB0);
  }

  static Color navBar(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFF4D429A) : const Color(0xFF4D429A);
  }

  static Color black(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFF121212) : const Color(0xFF121212);
  }
}
