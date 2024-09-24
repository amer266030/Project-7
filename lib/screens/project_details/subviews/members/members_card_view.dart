import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/img_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project_members.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../../../extensions/color_ext.dart';

class MembersCardView extends StatelessWidget {
  const MembersCardView(
      {super.key, required this.members, required this.cubit});
  final List<ProjectMembers> members;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.5,
      ),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return BorderedCardView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: AspectRatio(
                      aspectRatio: 1,
                      child: member.imageUrl == null
                          ? const Image(image: Img.logo, fit: BoxFit.cover)
                          : Image.network(member.imageUrl ?? '',
                              fit: BoxFit.cover),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${member.firstName ?? '?'} ${member.lastName ?? '?'}')
                              .styled(
                                  size: 12,
                                  color: C.primary(brightness),
                                  weight: FW.bold,
                                  lineLimit: 1),
                          Text(member.position ?? '?').styled(
                              size: 12,
                              color: C.text(brightness),
                              weight: FW.w300,
                              lineLimit: 1),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
