import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/user_projects/user_projects_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
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
            backgroundColor: C.bg1(brightness),
            appBar: AppBar(
                backgroundColor: C.bg1(brightness),
                title: const Text('My Projects')
                    .styled(size: 18, weight: FW.bold)),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: ProjectCardView(
                                                  project: proj,
                                                  withIndicator: false),
                                            )),
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
