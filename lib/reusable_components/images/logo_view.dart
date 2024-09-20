import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';

import '../../extensions/img_ext.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image(
          width: context.screenWidth * 0.1,
          image: Img.logo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
