import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/logo_view.dart';
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
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
          child: AspectRatio(
            aspectRatio: 2,
            child: InkWell(
              onTap: () {
                
              },
              child: ClipOval(
                child: cubit.user.imageUrl == null
                    ? LogoView()
                    : Image.network(
                        cubit.user.imageUrl!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        )),
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
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.github,
                  color: C.bg2,
                )),
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.link,
                  color: C.bg2,
                )),
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.linkedinIn,
                  color: C.bg2,
                )),
          ],
        ),
      ],
    );
  }
}
