import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/social_media_btn.dart';
import '../../../reusable_components/custom_text_field.dart';
import '../../../utils/validations.dart';
import '../profile_cubit.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

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
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: C.primary, width: 2),
                    color: C.bg1,
                    boxShadow: [
                      BoxShadow(
                        color: C.black.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 4,
                      )
                    ]),
                child: InkWell(
                  onTap: cubit.getImage,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                        child: cubit.avatar != null
                            ? Image.file(cubit.avatar!, fit: BoxFit.cover)
                            : cubit.user.imageUrl == null
                                ? const Icon(FontAwesomeIcons.image, size: 40)
                                : Image.network(cubit.user.imageUrl!,
                                    fit: BoxFit.cover)),
                  ),
                ),
              )),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Resume')
                .styled(size: 16, color: C.black, weight: FontWeight.w700),
            InkWell(
              onTap: cubit.pickPdfFile,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: C.primary,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Icon(FontAwesomeIcons.fileArrowUp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
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
