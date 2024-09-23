import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/projects/projects_cubit.dart';

import 'subviews/bootcamps_view.dart';
import 'subviews/top_rated_view.dart';

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
            if (state is ProjectsErrorState) {
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
                          size: 20,
                          weight: FontWeight.bold,
                          color: C.primary(context)),
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
                            TopRatedView(cubit.topRated, cubit),
                            BootCampsView(cubit: cubit),
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
