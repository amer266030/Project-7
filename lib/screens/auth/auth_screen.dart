import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_btn_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/otp_form_view.dart';
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
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              cubit.showAlert(context, false);
            } else if (state is AuthErrorState) {
              cubit.showAlert(context, true);
            } else if (state is AuthSuccessState) {
              cubit.navigateToHome(context);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(
                          cubit.headerTitle(),
                          style: const TS(
                            fontWeight: FW.bold,
                          ),
                        ),
                        Expanded(
                          child: cubit.isOtp
                              ? const OtpFormView()
                              : cubit.isSignup
                                  ? const SignUpFormView()
                                  : const SignInFormView(),
                        ),
                        Column(
                          children: [
                            if (!cubit.isOtp)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      cubit.isSignup
                                          ? "Already have an account?"
                                          : "Don't have an account?",
                                    ),
                                    const SizedBox(width: 4),
                                    CustomTextBtn(
                                        title: cubit.isSignup
                                            ? 'Sign In'
                                            : 'Sign Up',
                                        callback: cubit.toggleIsSignup),
                                  ],
                                ),
                              ),
                            AbsorbPointer(
                              absorbing:
                                  (state is AuthLoadingState) ? true : false,
                              child: Row(
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
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
