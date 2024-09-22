import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/validations.dart';

import '../../../extensions/color_ext.dart';
import '../../../reusable_components/buttons/elevated_btn_view.dart';
import '../../../utils/typedefs.dart';
import 'form_field_view.dart';

class SignUpFormView extends StatelessWidget {
  const SignUpFormView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Sign Up',
                  style: TS(fontSize: 24, fontWeight: FW.bold),
                ),
              ),
            ],
          ),
          Column(
            children: [
              FormFieldView(
                controller: cubit.firstNameController,
                title: 'First Name',
                hint: 'John',
                icon: CupertinoIcons.person_fill,
                validation: Validations.emptyFieldValidation,
              ),
              FormFieldView(
                controller: cubit.lastNameController,
                title: 'LastName',
                hint: 'Doe',
                icon: CupertinoIcons.person_fill,
                validation: Validations.emptyFieldValidation,
              ),
              FormFieldView(
                controller: cubit.emailController,
                title: 'Email',
                hint: 'abc@example.com',
                icon: CupertinoIcons.envelope_fill,
                validation: Validations.email,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedBtnView(
                      title: 'Get OTP',
                      icon: CupertinoIcons.chevron_right_circle_fill,
                      callBack: cubit.signUp),
                ],
              ),
               Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  color: C.bg3(context),
                  thickness: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
