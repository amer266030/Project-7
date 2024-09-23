import 'package:flutter/material.dart';

import '../extensions/color_ext.dart';

class DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const DotIndicator(
      {super.key, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            height: 6.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              color:
                  index == currentIndex ? C.primary(context) : C.bg1(context),
            ),
          ),
        );
      }),
    );
  }
}
