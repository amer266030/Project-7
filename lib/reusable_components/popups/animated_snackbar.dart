import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

AnimatedSnackBar animatedSnakbar({required String msg, required IconData icon }) {
  return AnimatedSnackBar(
    builder: ((context) {
      return  MaterialAnimatedSnackBar(
        messageText:msg,
        type: AnimatedSnackBarType.success,
        foregroundColor: C.primary,
        backgroundColor: C.secondary,
        iconData: icon,
      );
    }),
  );
}
