import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

AnimatedSnackBar animatedSnakbar({required String msg}) {
  return AnimatedSnackBar(
    builder: ((context) {
      return MaterialAnimatedSnackBar(
        messageText: msg,
        type: AnimatedSnackBarType.success,
        foregroundColor: C.primary(context),
        backgroundColor: C.secondary(context),
        iconData: CupertinoIcons.check_mark_circled_solid,
      );
    }),
  );
}
