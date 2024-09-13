import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';

import '../../../reusable_components/custom_text_field.dart';
import '../../../utils/validations.dart';

class SignUpFormView extends StatelessWidget {
  const SignUpFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
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
        Row(
          children: [
            const Expanded(child: Text('Email')),
            Expanded(
              flex: 3,
              child: CustomTextField(
                  controller: cubit.emailController,
                  hintText: 'abc@example.com',
                  validation: Validations.email),
            )
          ],
        )
      ],
    );
  }
}
