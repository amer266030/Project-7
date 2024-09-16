import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/user_projects/user_projects_cubit.dart';

import '../../model/project/project.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProjectsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<UserProjectsCubit>();
        return BlocListener<UserProjectsCubit, UserProjectsState>(
          listener: (context, state) {
            if (state is UserProjectsLoadingState) {
              cubit.showAlert(context, false);
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
                    const Text('User Projects'),
                    BlocBuilder<UserProjectsCubit, UserProjectsState>(
                      builder: (context, state) {
                        if (state is UserProjectsInitial) cubit.loadProfile();
                        return cubit.user.projects == null
                            ? const Text('No Projects Found')
                            : Expanded(
                                child: ListView(
                                  children: cubit.user.projects!
                                      .map(
                                        (proj) => InkWell(
                                            onTap: () =>
                                                cubit.navigateToDetails(
                                                    context, proj),
                                            child: ProjectCard(proj: proj)),
                                      )
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

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.proj});

  final Project proj;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project Id: ${proj.projectId ?? ''}'),
            Text('Project Name: ${proj.projectName ?? ''}'),
            Text('Admin Id: ${proj.adminId ?? ''}'),
          ],
        ),
      ),
    );
  }
}
