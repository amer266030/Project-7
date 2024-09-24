import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_details_card.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_screen.dart';

import '../../extensions/color_ext.dart';
import '../../model/project/project.dart';
import '../../reusable_components/images/background_img.dart';

class BootcampProjectsScreen extends StatelessWidget {
  const BootcampProjectsScreen(
      {super.key, required this.title, required this.projects});
  final String title;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: C.bg1(brightness),
      appBar: AppBar(
          backgroundColor: C.bg1(brightness),
          centerTitle: true,
          title: Text(title).styled(
              size: 20, weight: FontWeight.bold, color: C.primary(brightness))),
      body: Stack(
        children: [
          const BackgroundImg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: projects
                    .map((proj) => InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProjectDetailsScreen(project: proj))),
                        child: ProjectDetailsCard(project: proj)))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
