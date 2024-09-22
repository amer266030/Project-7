import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/blurred_card.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subviews/form_field_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';
import '../../../extensions/color_ext.dart';

class SignInFormView extends StatelessWidget {
  const SignInFormView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TS(fontSize: 24, fontWeight: FW.bold),
              ),
            ],
          ),
          FormFieldView(
              controller: cubit.emailController,
              title: 'Email',
              hint: 'abc@example.com',
              icon: CupertinoIcons.envelope_fill),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedBtnView(
                      title: 'Get OTP',
                      icon: CupertinoIcons.chevron_right_circle_fill,
                      callBack: cubit.signIn),
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
