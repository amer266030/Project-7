import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/custom_text_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/animated_snackbar.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/profile/subviews/edit_profile_view.dart';
import 'package:tuwaiq_project_pulse/screens/profile/subviews/show_profile_view.dart';

import '../../utils/typedefs.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>();
        return BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LoadingState || state is ErrorState) {
              cubit.showAlert(context, false);
            } else {
              cubit.dismissAlert(context);
              if (state is IdCopiedState) {
                animatedSnakbar(msg: 'ID copied to clipboard').show(context);
              }
              if (state is SuccessState) {
                cubit.showSnackBar(context, state.msg);
              }
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileInitial) cubit.loadProfile();
                  return Column(
                    children: [
                      cubit.isEdit
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: cubit.toggleIsEdit,
                                    icon: const Icon(
                                      CupertinoIcons.arrow_left,
                                      color: C.primary,
                                    )),
                                const Text('Profile')
                                    .styled(size: 18, weight: FW.bold),
                                CustomTextBtn(
                                  title: "Save",
                                  callback: cubit.updateProfile,
                                )
                              ],
                            )
                          : const Text('Profile')
                              .styled(size: 18, weight: FW.bold),
                      Expanded(
                        child: cubit.isEdit
                            ? EditProfileView(cubit: cubit)
                            : ShowProfileView(cubit: cubit),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
