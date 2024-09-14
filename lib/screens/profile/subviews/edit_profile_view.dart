import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../reusable_components/custom_text_field.dart';
import '../../../utils/validations.dart';
import '../profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            const Expanded(child: Text('First Name')),
            Expanded(
              flex: 3,
              child: CustomTextField(
                  controller: cubit.firstNameController,
                  hintText: 'John',
                  validation: Validations.emptyFieldValidation),
            )
          ],
        ),
        Row(
          children: [
            const Expanded(child: Text('Last Name')),
            Expanded(
              flex: 3,
              child: CustomTextField(
                  controller: cubit.lastNameController,
                  hintText: 'Doe',
                  validation: Validations.emptyFieldValidation),
            )
          ],
        ),
      ],
    );
  }
}
