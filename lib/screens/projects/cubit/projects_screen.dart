import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/logo_view.dart';
import 'package:tuwaiq_project_pulse/screens/projects/cubit/projects_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../../model/project/project.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProjectsCubit>();
        return BlocListener<ProjectsCubit, ProjectsState>(
          listener: (context, state) {
            if (state is ProjectsLoadingState) {
              cubit.showAlert(context, false);
            } else if (state is ProjectsErrorState) {
              cubit.showAlert(context, true);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TUWAIQ ACADEMY').styled(
                          size: 20, weight: FontWeight.bold, color: C.primary),
                      IconButton(
                          onPressed: () => (),
                          icon: const Icon(CupertinoIcons.search))
                    ],
                  ),
                  const Divider(),
                  BlocBuilder<ProjectsCubit, ProjectsState>(
                    builder: (context, state) {
                      if (state is ProjectsInitial) cubit.getProjects();
                      return Expanded(
                        child: ListView(
                          children: [
                            _TopRatedView(cubit.topRated, cubit),
                            _BootCampsView(cubit: cubit),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TopRatedView extends StatelessWidget {
  const _TopRatedView(this.projects, this.cubit);
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
          ).styled(size: 14, weight: FontWeight.bold, color: Colors.black),
        ),
        projects.firstOrNull == null
            ? const CircularProgressIndicator()
            : ProjectCardView(project: projects.first)
      ],
    );
  }
}

class _BootCampsView extends StatelessWidget {
  const _BootCampsView({required this.cubit});
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
              .map((entry) =>
                  BootCampCardView(title: entry.key, projects: entry.value))
              .toList(),
        )
      ],
    );
  }
}

class BootCampCardView extends StatelessWidget {
  const BootCampCardView(
      {super.key, required this.projects, required this.title});
  final String title;
  final List<Project> projects;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoView(),
              Text(title).styled(align: TextAlign.center, weight: FW.bold)
            ],
          ),
        ),
      ),
    );
  }
}
