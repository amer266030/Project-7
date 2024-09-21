import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';

class ProjectDetailsCardView extends StatelessWidget {
  const ProjectDetailsCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BorderedCardView(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
