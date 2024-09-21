import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/profile/subviews/edit_profile_view.dart';
import 'package:tuwaiq_project_pulse/screens/profile/subviews/show_profile_view.dart';

import '../../reusable_components/images/background_img.dart';
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
            if (state is ProfileLoadingState || state is ProfileErrorState) {
              cubit.showAlert(context, false);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                const BackgroundImg(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileInitial) cubit.loadProfile();
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        ShowProfileView(cubit: cubit),
                                    icon: const Icon(
                                      CupertinoIcons.arrow_left,
                                      color: C.primary,
                                    )),
                                const Text('Profile')
                                    .styled(size: 18, weight: FW.bold),
                                cubit.isEdit
                                    ? TextButton(
                                        onPressed: () {
                                          cubit.updateProfile();
                                        },
                                        child: const Text("Save").styled(
                                            size: 16, weight: FontWeight.w600))
                                    : const Text("")
                              ],
                            ),
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
              ],
            ),
          ),
        );
      }),
    );
  }
}

// TextButton(
// onPressed: () =>
// NetworkingApi.shared.supervisorApi.createProject(
// userId: '8c534564-cf6e-42eb-9377-6c08a81debd2',
// endDate: DateTime.now().add(Duration(days: 30)),
// edit: true,
// ),
// child: const Text('Create Project'),
// ),
