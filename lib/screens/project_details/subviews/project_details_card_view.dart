import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/img_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/link_type.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/model/project/project_type.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/social_media_btn.dart';
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
          _ImgView(url: project.logoUrl, cubit: cubit),
          Text(project.projectName ?? '').styled(size: 16, weight: FW.bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Project Details').styled(weight: FW.w500),
              IconButton(
                  onPressed: cubit.updateProjectBase,
                  icon: Icon(
                    Icons.save,
                    color: C.primary(context),
                    size: 22,
                  ))
            ],
          ),
          Divider(color: C.bg1(context), thickness: 2),
          ListItemWithTextField(
              title: 'Description',
              controller: cubit.descController,
              readOnly: cubit.readOnly),
          ListItemWithTextField(
              title: 'Bootcamp',
              controller: cubit.bootcampController,
              readOnly: cubit.readOnly),
          ListItemWithDropDown(
            title: 'Type',
            cubit: cubit,
          ),
          ListItemWithText(
              title: 'Date',
              body:
                  '${project.startDate?.toSlashDate()} - ${project.endDate?.toSlashDate()}'),
          ListItemWithText(
              title: 'Presentation',
              body: project.presentationDate!.toSlashDate()),
          Row(children: [
            Text('Edit ${project.allowEdit! ? 'Enabled' : 'Disabled'}')
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: LinkType.values
                      .map((link) => _LinkIconView(
                            url: '',
                            link: link,
                            controller: cubit.githubController,
                          ))
                      .toList()),
              IconButton(
                  onPressed: cubit.updateLinks,
                  icon: Icon(
                    Icons.save,
                    color: C.primary(context),
                    size: 22,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({this.url, required this.cubit});
  final String? url;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Expanded(
            child: InkWell(
              onTap: cubit.getImage,
              child: ClipRRect(
                borderRadius: BR.circular(12),
                child: url != null
                    ? Image.network(url!, fit: BoxFit.cover)
                    : const Image(image: Img.logo, fit: BoxFit.cover),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class ListItemWithText extends StatelessWidget {
  const ListItemWithText({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title).styled(weight: FW.w500)),
        const SizedBox(width: 4),
        Expanded(
            flex: 2,
            child: Text(body)
                .styled(size: 12, color: C.text(context), weight: FW.w300)),
      ],
    );
  }
}

class ListItemWithTextField extends StatelessWidget {
  const ListItemWithTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.readOnly});
  final String title;
  final TextEditingController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title).styled(weight: FW.w500)),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: TextField(
                  readOnly: readOnly,
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 12, fontWeight: FW.w300),
                  decoration: const InputDecoration(
                    isDense: true, // Reduces vertical space
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: 4), // Removes vertical padding
                    border: InputBorder.none, // Removes the border (optional)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListItemWithDropDown extends StatelessWidget {
  const ListItemWithDropDown(
      {super.key, required this.title, required this.cubit});
  final String title;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title).styled(weight: FW.w500)),
        const SizedBox(width: 4),
        Expanded(
          child: DropdownButton<ProjectType>(
              value: cubit.selectedType,
              isExpanded: true,
              items: ProjectType.values.map((ProjectType type) {
                return DropdownMenuItem<ProjectType>(
                    value: type,
                    child: Text(type.toString().split('.').last)
                        .styled(color: C.text(context), weight: FW.w300));
              }).toList(),
              onChanged: cubit.readOnly
                  ? null
                  : (ProjectType? newValue) => cubit.changeType(newValue!)),
        ),
        const Spacer()
      ],
    );
  }
}

class _LinkIconView extends StatelessWidget {
  const _LinkIconView(
      {required this.url, required this.link, required this.controller});
  final String? url;
  final LinkType? link;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: SocialMediaBtn(
          title: link?.name ?? '',
          hint: 'https://',
          controller: controller,
          icon: link?.icon() ?? Icons.circle,
          smallIcon: true,
        ));
  }
}
