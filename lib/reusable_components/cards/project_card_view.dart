import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import '../../model/project/project.dart';
import '../../utils/typedefs.dart';

class ProjectCardView extends StatelessWidget {
  const ProjectCardView({super.key, required this.project, this.cubit});
  final Project project;
  final ProjectDetailsCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenWidth * 0.45,
      width: context.screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          right: BorderSide(
            width: 7,
            color: C.primary,
          ),
          bottom: BorderSide(
            width: 7,
            color: C.primary,
          ),
        ),
        color: C.secondaryWOpacity,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                  onTap: cubit == null ? () => () : cubit!.getImage,
                  child: cubit?.selectedImg == null
                      ? ClipRRect(
                          borderRadius: BR.circular(16),
                          child: const Placeholder())
                      : ClipRRect(
                          borderRadius: BR.circular(16),
                          child: Image.file(cubit!.selectedImg!)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${project.projectName ?? 'None!'}',
                    maxLines: 1,
                  ),
                  Text('Created: ${project.createAt ?? ''}'),
                  Text('Deadline: ${project.timeEndEdit}'),
                  Text('Can Edit: ${project.allowEdit}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
