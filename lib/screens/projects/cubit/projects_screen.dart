import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/projects/cubit/projects_cubit.dart';

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
                          icon: Icon(CupertinoIcons.search))
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
                            ...cubit.groupedProjects.entries
                                .map((entry) => _BootCampsView(
                                    projects: entry.value,
                                    cubit: cubit,
                                    bootcampTitle: entry.key))
                                .toList(),
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
  const _BootCampsView(
      {required this.projects,
      required this.cubit,
      required this.bootcampTitle});
  final List<Project> projects;
  final String bootcampTitle;
  final ProjectsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            bootcampTitle, // Display Bootcamp name as header
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Display the list of projects under this bootcamp
        ...projects.map((project) => ListTile(
              title: Text(project.projectName ?? '?'),
              subtitle: Text('Rating: ${project.rating}'),
            ))
      ],
    );
  }
}

class BootCampCardView extends StatelessWidget {
  const BootCampCardView({super.key, required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
