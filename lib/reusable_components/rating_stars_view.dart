import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';

class RatingStarsView extends StatelessWidget {
  final double rating;
  final int totalStars;

  const RatingStarsView({super.key, required this.rating, this.totalStars = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalStars, (index) {
        if (rating >= index + 1) {
          return const Icon(
            Icons.star,
            color: C.primary,
          );
        } else if (rating >= index + 0.5) {
          return const Icon(
            Icons.star_half,
            color: C.primary,
          );
        } else {
          return const Icon(
            Icons.star_border,
            color: C.primary,
          );
        }
      }),
    );
  }
}
