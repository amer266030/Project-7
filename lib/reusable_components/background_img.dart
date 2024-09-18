import 'package:flutter/material.dart';

import '../extensions/img_ext.dart';

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: Image(image: Img.mountain, fit: BoxFit.cover),
      ),
    );
  }
}
