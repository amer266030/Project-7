import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg1(context),
      body: const SafeArea(
          child: Column(
        children: [
          Text('Hello'),
        ],
      )),
    );
  }
}
