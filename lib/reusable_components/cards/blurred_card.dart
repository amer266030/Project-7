import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';
import 'package:tuwaiq_project_pulse/reusable_components/logo_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../extensions/color_ext.dart';

class BlurredCard extends StatelessWidget {
  const BlurredCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Allow overflow beyond the bounds of the card
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BR.circular(24)),
            surfaceTintColor: C.secondary,
            shadowColor: C.secondary.withOpacity(0.3),
            color: C.secondary.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  const _BlurFilter(),
                  child,
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: context.screenWidth * -0.1,
            left: 0,
            right: 0,
            child: const Center(
              child: LogoView(key: ValueKey('LogoView')), // Define unique key
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurFilter extends StatelessWidget {
  const _BlurFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        decoration: BoxDecoration(color: C.secondary.withOpacity(0.5)),
      ),
    );
  }
}
