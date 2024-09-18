import 'package:flutter/material.dart';

import '../../extensions/color_ext.dart';

class BorderedCardView extends StatelessWidget {
  const BorderedCardView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: C.secondary
              .withOpacity(0.7), // Keeps the semi-transparent background
          borderRadius: BorderRadius.circular(16),
          border: const Border(
            right: BorderSide(
                color: C.primary, width: 6), // Solid border on the right
            bottom: BorderSide(
                color: C.primary, width: 6), // Solid border at the bottom
          ),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      ),
    );
  }
}
