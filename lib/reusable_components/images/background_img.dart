import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

import '../../extensions/img_ext.dart';

import 'dart:ui';

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Opacity(
              opacity: 0.8, // Adjust the opacity as needed
              child: Image(image: Img.mountain, fit: BoxFit.cover),
            ),
            // // Blur effect
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(color: C.bg1(context).withOpacity(0.1))),
          ],
        ),
      ),
    );
  }
}
