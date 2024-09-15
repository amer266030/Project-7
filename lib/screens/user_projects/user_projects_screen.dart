import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/user_projects/user_projects_cubit.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProjectsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<UserProjectsCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('User Projects'),
                  BlocBuilder<UserProjectsCubit, UserProjectsState>(
                    builder: (context, state) {
                      if (state is UserProjectsInitial) cubit.loadProfile();
                      return Expanded(
                        child: ListView(
                          children: cubit.user.projects!
                              .map(
                                (proj) => Column(
                                  children: [
                                    Text(proj.projectId ?? ''),
                                    Text(proj.projectName ?? ''),
                                    Text(proj.userId ?? ''),
                                    Text(proj.adminId ?? '')
                                  ],
                                ),
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
        );
      }),
    );
  }
}
