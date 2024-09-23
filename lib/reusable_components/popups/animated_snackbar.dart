import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

AnimatedSnackBar animatedSnakbar({
  required String msg,
  AnimatedSnackBarType type = AnimatedSnackBarType.success,
}) {
  return AnimatedSnackBar(
    builder: ((context) {
      return MaterialAnimatedSnackBar(
        messageText: msg,
        type: type,
        foregroundColor: C.primary,
        backgroundColor: C.secondary,
        iconData: CupertinoIcons.check_mark_circled_solid,
      );
    }),
  );
}
