import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/public/public_cubit.dart';

import '../../model/project.dart';

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
            // TODO: implement listener
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: cubit.getProjects,
                      child: Text('Get projects'),
                    ),
                    BlocBuilder<PublicCubit, PublicState>(
                      builder: (context, state) {
                        return Expanded(
                          child: ListView(
                            children: cubit.projects
                                .map((project) =>
                                    ProjectDetails(project: project))
                                .toList(),
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

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(project.projectName ?? 'None'),
        Text(project.bootcampName ?? 'None'),
      ],
    );
  }
}
