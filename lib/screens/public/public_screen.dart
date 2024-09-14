import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/public/public_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../model/project/project.dart';

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
                    const Text('Projects', style: TS(fontWeight: FW.bold)),
                    const Divider(),
                    BlocBuilder<PublicCubit, PublicState>(
                      builder: (context, state) {
                        if (state is PublicInitial) cubit.getProjects();
                        return Expanded(
                          child: ListView(
                            children: cubit.projects
                                .map(
                                  (project) => InkWell(
                                    child: ProjectDetails(project: project),
                                    onTap: () => cubit.getProjectById(
                                        project.projectId ?? ''),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${project.projectId}'),
              Text('User ID: ${project.userId}'),
              Text('Admin ID: ${project.adminId ?? 'None'}'),
              Text('Name: ${project.projectName ?? 'None'}'),
              Text('BootCamp: ${project.bootcampName ?? 'None'}'),
              Text('Type: ${project.type ?? 'None'}'),
              Text('Created At: ${project.createAt ?? 'None'}'),
              Text('End Date: ${project.endDate ?? 'None'}'),
              Text('Time End Edit: ${project.timeEndEdit ?? 'None'}'),
              Text('Presentation Date: ${project.presentationDate ?? 'None'}'),
              Text('Project Desc. ${project.projectDescription ?? 'None'}'),
              Text('logoUrl: ${project.logoUrl ?? 'None'}'),
              Text('Presentation URL: ${project.presentationUrl ?? 'None'}'),
              Text('Project Name: ${project.projectName ?? 'None'}'),
              Text('Is public: ${project.isPublic ?? false}'),
              Text('User ID: ${project.allowEdit ?? false}'),
              const Divider(),
              const Text(
                'Images',
                style: TS(fontWeight: FW.w500),
              ),
              ...project.imagesProject!.map(
                (img) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('id: ${img.id.toString()}'),
                    Text('url: ${img.url}'),
                  ],
                ),
              ),
              const Text(
                'Members',
                style: TS(fontWeight: FW.w500),
              ),
              ...project.membersProject!.map(
                (member) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${member.firstName} ${member.lastName}'),
                  ],
                ),
              ),
              const Text(
                'Links',
                style: TS(fontWeight: FW.w500),
              ),
              ...project.linksProject!.map(
                (link) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('type: ${link.type}'),
                    Text('url: ${link.url}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
