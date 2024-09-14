import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_text_field.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';

import '../../../utils/validations.dart';

class SignInFormView extends StatelessWidget {
  const SignInFormView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
