import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AnimatedSnackBar animatedSnakbar({
  required String msg,
  AnimatedSnackBarType type = AnimatedSnackBarType.success,
}) {
  return AnimatedSnackBar(
    builder: ((context) {
      return MaterialAnimatedSnackBar(
        messageText: msg,
        type: type,
        foregroundColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        iconData: CupertinoIcons.check_mark_circled_solid,
      );
    }),
  );
}
