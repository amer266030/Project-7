import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
    final pageController = PageController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Top Rated',
          ).styled(size: 14, weight: FontWeight.bold, color: Colors.black),
        ),
        projects.firstOrNull == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        cubit.setCurrentPageIndex(index);
                      },
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return ProjectCardView(
                          project: projects[index],
                          projectsCubit: cubit,
                          withIndicator: true,
                          pageController: pageController,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
