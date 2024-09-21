import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/logo_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_popup_view.dart';
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
            child: InkWell(
              onTap: () async {
                await cubit.updateLogo();
              },
              child: ClipOval(
                  child: cubit.user.imageUrl == null
                      ? LogoView()
                      //   : Image.network(
                      //     cubit.user.imageUrl!,
                      //     fit: BoxFit.cover,
                      // )
                      : Image.file(
                          File(cubit.user.imageUrl!),
                          fit: BoxFit.cover,
                        )),
            ),
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
            SocialMediaLinks(
                title: "Github",
                hint: "mohammed_19994",
                controller: cubit.githubController,
                icon: FontAwesomeIcons.github),
            SocialMediaLinks(
                title: "Bindlink",
                hint: "mohammed_19994",
                controller: cubit.bindlinkController,
                icon: FontAwesomeIcons.link),
            SocialMediaLinks(
                title: "Linkedin",
                hint: "mohammed_19994",
                controller: cubit.linkedinController,
                icon: FontAwesomeIcons.linkedinIn),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedBtnView(
          callBack: () {
            cubit.updateProfile();
          },
          title: 'Save',
        )
      ],
    );
  }
}

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopupView(
                title: "Update URL",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(title).styled(
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    CustomTextField(
                      controller: controller,
                      hintText: hint,
                      validation: Validations.emptyFieldValidation,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ElevatedBtnView(
                        title: 'Save',
                        callBack: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                callback: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
        icon: FaIcon(
          icon,
          color: C.bg2,
        ));
  }
}
