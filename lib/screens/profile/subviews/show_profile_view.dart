import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/animated_snackbar.dart';
import 'package:tuwaiq_project_pulse/screens/admin/user_role.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_popup_view.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/profile/subviews/profile_card_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../reusable_components/list_item_view.dart';
import '../../../reusable_components/pdf_preview/pdf_preview.dart';

class ShowProfileView extends StatelessWidget {
  const ShowProfileView({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is NoUrlState) {
            animatedSnakbar(
                    msg: 'URL is not available',
                    icon: CupertinoIcons.xmark_circle_fill)
                .show(context);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ProfileCardView(cubit),
            ),
            Expanded(
              child: ListView(
                children: [
                  if (cubit.user.role == UserRole.admin.name)
                    ListItemView(
                        label: 'Change User Role',
                        callback: () => cubit.navigateToAdminScreen(context)),
                  if (cubit.user.role != UserRole.user.name)
                    ListItemView(
                        label: 'Create Project',
                        callback: () =>
                            cubit.navigateToSupervisorScreen(context)),
                  ListItemView(label: 'Account', callback: cubit.toggleIsEdit),
                  ListItemView(
                    label: 'Resume',
                    callback: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomPopupView(
                            title: "Resume",
                            child: cubit.user.link?.resume != null
                                ? PdfPreview(url: cubit.user.link!.resume)
                                : const Text('None!'),
                            callback: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                  ),
                  ListItemView(
                      label: 'Projects',
                      callback: () => cubit.navigateToUserProjects(context)),
                  ListItemView(
                      label: 'Logout', callback: () => cubit.logOut(context)),
                  const Divider(),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.github,
                          color: C.bg2,
                        ),
                        onPressed: () {
                          context
                              .read<ProfileCubit>()
                              .launchLink(cubit.user.link?.github);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.link,
                          color: C.bg2,
                        ),
                        onPressed: () {
                          context
                              .read<ProfileCubit>()
                              .launchLink(cubit.user.link?.bindlink);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.linkedinIn,
                          color: C.bg2,
                        ),
                        onPressed: () {
                          context
                              .read<ProfileCubit>()
                              .launchLink(cubit.user.link?.linkedin);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
