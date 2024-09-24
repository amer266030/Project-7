import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/project_details_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/presentation_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/rating_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/screen_shots_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectDetailsCubit(),
      child: Builder(builder: (context) {
        final brightness = Theme.of(context).brightness;
        final cubit = context.read<ProjectDetailsCubit>();
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocListener<ProjectDetailsCubit, ProjectDetailsState>(
            listener: (context, state) {
              if (state is SuccessState) {
                cubit.showSnackBar(context: context, msg: state.msg);
              }
              if (state is ErrorState) {
                cubit.showSnackBar(
                    context: context,
                    msg: state.msg,
                    type: AnimatedSnackBarType.error);
              }
              if (state is ProjectDeletedState) {
                Navigator.of(context).pop();
              }
            },
            child: Scaffold(
              backgroundColor: C.bg1(brightness),
              appBar: AppBar(
                title: const Text(
                  'Project Details',
                ).styled(size: 18, weight: FW.bold, color: C.text(brightness)),
                backgroundColor: C.bg1(brightness),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () => cubit.navigateToEdit(context),
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => cubit.deleteProject(),
                      icon: const Icon(Icons.delete))
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
                    builder: (context, state) {
                      if (state is ProjectDetailsInitial) {
                        cubit.loadProject(project);
                      }
                      return ListView(
                        children: [
                          ProjectDetailsCardView(
                              project: project, cubit: cubit),
                          RatingCardView(
                              rating: double.tryParse('${project.rating}') ?? 0,
                              cubit: cubit),
                          ScreenShotsView(
                              cubit: cubit,
                              images: cubit.project.imagesProject ?? []),
                          PresentationView(cubit: cubit),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
