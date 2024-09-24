import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';

import '../../../../extensions/color_ext.dart';
import '../../../../utils/typedefs.dart';
import '../../project_details_cubit.dart';

import 'package:flutter/material.dart';

import '../project_details_card_view.dart';

class AddMembersView extends StatelessWidget {
  const AddMembersView({super.key, required this.cubit});
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AddMemberCardView(
            idController: cubit.member1IDController,
            roleController: cubit.member1RoleController),
        _AddMemberCardView(
            idController: cubit.member2IDController,
            roleController: cubit.member2RoleController),
        _AddMemberCardView(
            idController: cubit.member3IDController,
            roleController: cubit.member3RoleController),
        _AddMemberCardView(
            idController: cubit.member4IDController,
            roleController: cubit.member4RoleController),
      ],
    );
  }
}

class _AddMemberCardView extends StatelessWidget {
  const _AddMemberCardView(
      {required this.idController, required this.roleController});
  final TextEditingController idController;
  final TextEditingController roleController;

  @override
  Widget build(BuildContext context) {
    return BorderedCardView(
      child: Column(
        children: [
          ListItemWithTextField(
              title: 'User Id', controller: idController, readOnly: false),
          const SizedBox(height: 16),
          ListItemWithTextField(
              title: 'Role', controller: roleController, readOnly: false),
        ],
      ),
    );
  }
}
