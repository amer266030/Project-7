import 'package:flutter/material.dart';

extension C on Colors {
  // Primary color based on the current theme mode
  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFE3D8FF) // Dark theme primary color
        : const Color(0xFF4F29B7); // Light theme primary color
  }

  // Secondary color based on the current theme mode
  static Color secondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFBB86FC) // Dark theme secondary color
        : const Color(0xFFE3D8FF); // Light theme secondary color
  }

  static Color bg1(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF121212) // Dark theme background
        : const Color(0xFFF5F5F7); // Light theme background
  }

  static Color bg2(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E) // Dark theme background 2
        : const Color(0xFFF9FAFB); // Light theme background 2
  }

  static Color navBar(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFBB86FC) // Dark theme navbar
        : const Color(0xFF4D429A); // Light theme navbar
  }

  static Color text(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF3A3A3A) // Dark theme navbar
        : const Color(0xFFF5F5F7); // Light theme navbar
  }
}
