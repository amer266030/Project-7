import 'package:flutter/material.dart';

extension C on Colors {
  // Primary color based on the current brightness
  static Color primary(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF4F29B7) // Dark theme primary color
        : const Color(0xFF4F29B7); // Light theme primary color
  }

  // Secondary color based on the current brightness
  static Color secondary(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFE3D8FF) // Dark theme secondary color
        : const Color(0xFFE3D8FF); // Light theme secondary color
  }

  static Color secondaryWOpacity(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xB3E3D8FF) // Dark theme secondary color
        : const Color(0xB3E3D8FF); // Light theme secondary color
  }

  // Background color 1 based on the current brightness
  static Color bg1(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFF5F5F7) // Dark theme background
        : const Color(0xFFF5F5F7); // Light theme background
  }

  // Background color 2 based on the current brightness
  static Color bg2(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFF9FAFB) // Dark theme background 2
        : const Color(0xFFF9FAFB); // Light theme background 2
  }

  static Color bg3(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF4A0EB0) // Dark theme background 2
        : const Color(0xFF4A0EB0); // Light theme background 2
  }

  // Navbar color based on the current brightness
  static Color navBar(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF4D429A) // Dark theme navbar
        : const Color(0xFF4D429A); // Light theme navbar
  }

  // Text color based on the current brightness
  static Color text(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF121212) // Dark theme text color
        : const Color(0xFF121212); // Light theme text color
  }
}
