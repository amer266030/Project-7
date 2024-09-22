import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/img_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/link_type.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class ProjectDetailsCardView extends StatelessWidget {
  const ProjectDetailsCardView(
      {super.key, required this.project, required this.cubit});
  final Project project;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BorderedCardView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ImgView(url: project.logoUrl),
          Text(project.projectName ?? '').styled(size: 16, weight: FW.bold),
          Row(
            children: [const Text('Project Details').styled(weight: FW.w500)],
          ),
          const Divider(color: C.bg1, thickness: 2),
          ListItemWithText(
              title: 'Description', controller: cubit.descController),
          // _LineItemView(
          //     title: 'Project Description', body: project.projectDescription),
          _LineItemView(title: 'Bootcamp', body: project.bootcampName),
          _LineItemView(title: 'Type', body: project.type?.name),
          _LineItemView(
              title: 'Date',
              body:
                  '${project.startDate?.toSlashDate()} - ${project.endDate?.toSlashDate()}'),
          _LineItemView(
              title: 'Presentation Date',
              body: project.presentationDate?.toSlashDate()),
          Row(
            children: project.linksProject != null
                ? project.linksProject!
                    .map((link) =>
                        _LinkIconView(url: link.url, icon: link.type?.icon()))
                    .toList()
                : [],
          )
        ],
      ),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            child: ClipRRect(
              borderRadius: BR.circular(12),
              child: url != null
                  ? Image.network(url!, fit: BoxFit.cover)
                  : const Image(image: Img.logo, fit: BoxFit.cover),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ListItemWithText extends StatelessWidget {
  const ListItemWithText(
      {super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title).styled(weight: FW.w500),
        const SizedBox(width: 4),
        Flexible(
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 12,
            ),
            decoration: const InputDecoration(
              isDense: true, // Reduces vertical space
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: 4), // Removes vertical padding
              border: InputBorder.none, // Removes the border (optional)
            ),
          ),
        ),
      ],
    );
  }
}

class _LineItemView extends StatelessWidget {
  const _LineItemView({required this.title, required this.body});
  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title).styled(weight: FW.w500),
        const SizedBox(width: 4),
        Flexible(
          child: Text(body ?? 'None').styled(color: C.black, weight: FW.w300),
        ),
      ],
    );
  }
}

class _LinkIconView extends StatelessWidget {
  const _LinkIconView({required this.url, required this.icon});
  final String? url;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => (), icon: Icon(icon));
  }
}
