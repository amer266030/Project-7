
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int totalStars;

  const RatingStars({super.key, required this.rating, this.totalStars = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalStars, (index) {
        if (rating >= index + 1) {
          return Icon(
            Icons.star,
            color: C.primary,
            size: context.screenWidth * 0.07,
          );
        } else if (rating >= index + 0.5) {
          return Icon(
            Icons.star_half,
            color: C.primary,
            size: context.screenWidth * 0.07,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: C.primary,
            size: context.screenWidth * 0.07,
          );
        }
      }),
    );
  }
}
