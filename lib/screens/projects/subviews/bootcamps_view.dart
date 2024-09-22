import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../../model/project/project.dart';
import '../../../reusable_components/cards/bordered_card_view.dart';
import '../../../reusable_components/images/logo_view.dart';
import '../../../utils/typedefs.dart';
import '../projects_cubit.dart';

class BootCampsView extends StatelessWidget {
  const BootCampsView({super.key, required this.cubit});
  final ProjectsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Tuwaiq Gallery', // Display Bootcamp name as header
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: cubit.groupedProjects.entries
              .map((entry) => InkWell(
                  onTap: () => cubit.navigateToBootCampProjects(
                      context: context,
                      title: entry.key,
                      projects: entry.value),
                  child: _BootCampCardView(
                      title: entry.key, projects: entry.value)))
              .toList(),
        )
      ],
    );
  }
}

class _BootCampCardView extends StatelessWidget {
  const _BootCampCardView(
      {super.key, required this.projects, required this.title});
  final String title;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return BorderedCardView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LogoView(),
          Text(title)
              .styled(context: context, align: TextAlign.center, weight: FW.bold, lineLimit: 2)
        ],
      ),
    );
  }
}
