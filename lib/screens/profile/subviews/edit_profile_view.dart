import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/social_media_btn.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/logo_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/animated_snackbar.dart';
import '../../../reusable_components/custom_text_field.dart';
import '../../../utils/validations.dart';
import '../profile_cubit.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
          child: AspectRatio(
              aspectRatio: 2,
              child: ClipOval(
                  child: cubit.user.imageUrl == null
                      ? Image.network(
                          'https://picsum.photos/200/200',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          cubit.user.imageUrl!,
                          fit: BoxFit.cover,
                        ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: ElevatedBtnView(
            title: 'Generate Image',
            callBack: () async {
              await cubit.updateLogo();
              animatedSnakbar(msg: 'Profile image updated successfully')
                  .show(context);
            },
          ),
        ),
        const Text('First Name')
            .styled(size: 16, color: C.black, weight: FontWeight.w700),
        CustomTextField(
            controller: cubit.firstNameController,
            hintText: 'John',
            validation: Validations.emptyFieldValidation),
        const Text('Last Name')
            .styled(size: 16, color: C.black, weight: FontWeight.w700),
        CustomTextField(
            controller: cubit.lastNameController,
            hintText: 'Doe',
            validation: Validations.emptyFieldValidation),
        const Text('Email')
            .styled(size: 16, color: C.black, weight: FontWeight.w700),
        CustomTextField(
            controller: cubit.emailController,
            hintText: 'user@gmai.com',
            validation: Validations.email),
        Row(
          children: [
            Expanded(
                child: const Text('Resume')
                    .styled(size: 16, color: C.black, weight: FontWeight.w700)),
          ],
        ),
        const Text('Social Media')
            .styled(size: 16, color: C.black, weight: FontWeight.w700),
        Row(
          children: [
            SocialMediaBtn(
                title: "Github",
                hint: "mohammed_19994",
                controller: cubit.githubController,
                icon: FontAwesomeIcons.github),
            SocialMediaBtn(
                title: "Bindlink",
                hint: "mohammed_19994",
                controller: cubit.bindlinkController,
                icon: FontAwesomeIcons.link),
            SocialMediaBtn(
                title: "Linkedin",
                hint: "mohammed_19994",
                controller: cubit.linkedinController,
                icon: FontAwesomeIcons.linkedinIn),
          ],
        ),
      ],
    );
  }
}
