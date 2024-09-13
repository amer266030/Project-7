import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_btn_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/otp_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/sign_in_form_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/sign_up_form_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../reusable_components/custom_text_btn.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Text(
                        cubit.headerTitle(),
                        style: TS(
                          fontWeight: FW.bold,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return cubit.isOtp
                            ? const OtpView()
                            : cubit.isSignup
                                ? const SignUpFormView()
                                : const SignInFormView();
                      },
                    ),
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Column(children: [
                        if (state is! OTPState)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  cubit.isSignup
                                      ? "Already have an account?"
                                      : "Don't have an account?",
                                ),
                                const SizedBox(width: 4),
                                CustomTextBtn(
                                    title:
                                        cubit.isSignup ? 'Sign In' : 'Sign Up',
                                    callback: cubit.toggleIsSignup),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomBtnView(
                                title: 'SUBMIT',
                                callBack: cubit.isOtp
                                    ? cubit.verifyOtp
                                    : cubit.isSignup
                                        ? cubit.signUp
                                        : cubit.signIn,
                              ),
                            ),
                          ],
                        )
                      ]);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
