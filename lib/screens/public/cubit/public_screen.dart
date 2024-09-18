import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/public/cubit/public_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../../model/project/project.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<PublicCubit>();
        return BlocListener<PublicCubit, PublicState>(
          listener: (context, state) {
            if (state is PublicLoadingState) {
              cubit.showAlert(context, false);
            } else if (state is PublicErrorState) {
              cubit.showAlert(context, true);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tuwaiq Gallery',
                        style: TS(fontWeight: FW.bold)),
                    const Divider(),
                    BlocBuilder<PublicCubit, PublicState>(
                      builder: (context, state) {
                        if (state is PublicInitial) cubit.getProjects();
                        return Expanded(
                          child: ListView(
                            children: [
                              _TopRated(cubit.topRated, cubit),
                              ...cubit.groupedProjects.entries
                                  .map((entry) => _BootCampProjects(
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
          ),
        );
      }),
    );
  }
}

class _TopRated extends StatelessWidget {
  const _TopRated(this.projects, this.cubit);
  final List<Project> projects;
  final PublicCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Top Rated', // Display Bootcamp name as header
          ).styled(size: 20, weight: FontWeight.bold, color: C.primary),
        ),
        projects.firstOrNull == null
            ? const CircularProgressIndicator()
            : ProjectCardView(project: projects.first)
      ],
    );
  }
}

class _BootCampProjects extends StatelessWidget {
  const _BootCampProjects(
      {required this.projects,
      required this.cubit,
      required this.bootcampTitle});
  final List<Project> projects;
  final String bootcampTitle;
  final PublicCubit cubit;

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
