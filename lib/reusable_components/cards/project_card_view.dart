import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import '../../model/project/project.dart';
import '../../utils/typedefs.dart';

class ProjectCardView extends StatelessWidget {
  const ProjectCardView(
      {super.key, required this.project, required this.cubit});
  final Project project;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                  onTap: cubit.getImage,
                  child: cubit.selectedImg == null
                      ? ClipRRect(
                          borderRadius: BR.circular(16),
                          child: const Placeholder())
                      : ClipRRect(
                          borderRadius: BR.circular(16),
                          child: Image.file(cubit.selectedImg!)),
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
                    'Admin ${project.adminId}',
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
