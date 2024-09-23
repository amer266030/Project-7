import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../../model/project/project.dart';
import '../../../reusable_components/cards/project_card_view.dart';
import '../projects_cubit.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView(this.projects, this.cubit, {super.key});
  final List<Project> projects;
  final ProjectsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Top Rated', // Display Bootcamp name as header
          ).styled(size: 14, weight: FontWeight.bold, color: C.text(context)),
        ),
        projects.firstOrNull == null
            ? const CircularProgressIndicator()
            : ProjectCardView(project: projects.first)
      ],
    );
  }
}
