import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/bottom_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/blurred_card.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/otp_form_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/sign_in_form_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/subViews/sign_up_form_view.dart';

import '../../extensions/color_ext.dart';
import '../../reusable_components/images/background_img.dart';
import '../../reusable_components/images/logo_view.dart';

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
            if (state is LoadingState) {
              cubit.showAlert(context, false);
            } else if (state is ErrorState) {
              cubit.showAlert(context, true);
            } else if (state is SuccessState) {
              cubit.navigateToHome(context);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              const BackgroundImg(),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) cubit.initial();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SafeArea(
                          child: Text('')), // To Center the list View
                      Expanded(
                        child: ListView(
                          children: [
                            if (state is AuthInitial)
                              const LogoView()
                            else
                              BlurredCard(child: _AnimatedBody(cubit: cubit))
                          ],
                        ),
                      ),
                      if (!cubit.isOtp)
                        AbsorbPointer(
                          absorbing: (state is LoadingState) ? true : false,
                          child: _BottomButtons(cubit: cubit),
                        )
                    ],
                  );
                },
              ),
            ]),
          ),
        );
      }),
    );
  }
}

class _AnimatedBody extends StatelessWidget {
  const _AnimatedBody({required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: cubit.isOtp
            ? OtpFormView(key: const ValueKey('OtpFormView'), cubit: cubit)
            : cubit.isSignup
                ? SignUpFormView(
                    key: const ValueKey('SignUpFormView'), cubit: cubit)
                : SignInFormView(
                    key: const ValueKey('SignInFormView'), cubit: cubit),
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BottomBtnView(
            title: 'Sign Up',
            btnColor: cubit.isSignup ? C.primary : C.bg1,
            textColor: cubit.isSignup ? C.bg1 : C.primary,
            callBack: cubit.isSignup ? () => () : cubit.toggleIsSignup,
          ),
        ),
        Expanded(
          child: BottomBtnView(
            title: 'Sign In',
            btnColor: !cubit.isSignup ? C.primary : C.bg1,
            textColor: !cubit.isSignup ? C.bg1 : C.primary,
            callBack: !cubit.isSignup ? () => () : cubit.toggleIsSignup,
          ),
        ),
      ],
    );
  }
}
