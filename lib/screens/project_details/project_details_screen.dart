import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_details_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_text_field.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/presentation_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/rating_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/subviews/screen_shots_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../utils/validations.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectDetailsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProjectDetailsCubit>();
        return Scaffold(
          appBar: AppBar(
            title:
                const Text('Project Details').styled(size: 18, weight: FW.bold),
            centerTitle: true,
            actions: [],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  InkWell(
                    onTap: cubit.getImage,
                    child:
                        BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
                      builder: (context, state) {
                        if (state is ProjectDetailsInitial) {
                          cubit.loadProject(project);
                        }
                        return ProjectDetailsCardView(
                            project: project, cubit: cubit);
                      },
                    ),
                  ),
                  RatingCardView(
                      rating: double.tryParse('${project.rating}') ?? 0,
                      cubit: cubit),
                  ScreenShotsView(
                      cubit: cubit, images: cubit.project.imagesProject ?? []),
                  PresentationView(cubit: cubit),
                  TextButton(
                      onPressed: () => cubit.updateProjectBase(project),
                      child: const Text('Update Proj Base')),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TextFieldContainer extends StatelessWidget {
  const _TextFieldContainer({required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text('Title:', style: TS(fontWeight: FW.w600))),
        Expanded(
          flex: 3,
          child: CustomTextField(
            hintText: hintText,
            controller: controller,
            validation: Validations.emptyFieldValidation,
          ),
        )
      ],
    );
  }
}
