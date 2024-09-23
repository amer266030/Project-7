import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/custom_text_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../../extensions/color_ext.dart';

class OtpFormView extends StatelessWidget {
  const OtpFormView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final defaultPinTheme = PinTheme(
      textStyle: const TextStyle(
          fontSize: 24, color: Colors.black, fontWeight: FW.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(50),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
          color: C.primary(brightness),
          width: 2,
          strokeAlign: BorderSide.strokeAlignCenter),
      borderRadius: BorderRadius.circular(50),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white38,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OTP',
                style: TS(fontSize: 24, fontWeight: FW.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                const Text(
                  'An OTP verification code was sent to',
                  style: TS(color: Colors.black45),
                ),
                Text(
                  cubit.emailController.text,
                  style: TS(color: C.primary(brightness)),
                ),
              ],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'OTP Verification code: *',
                  style: TS(fontWeight: FW.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 7,
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    length: 6,
                    showCursor: true,
                    onCompleted: (pin) {
                      cubit.otp = int.tryParse(pin) ?? -1;
                      cubit.verifyOtp();
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              CustomTextBtn(title: 'Cancel', callback: cubit.toggleIsOTP)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              onPressed: cubit.toggleIsOTP,
              child:
                  Text('Resend OTP', style: TS(color: C.primary(brightness))),
            ),
          ),
          ElevatedBtnView(
            title: 'Sign In',
            icon: CupertinoIcons.chevron_right_circle_fill,
            callBack: cubit.verifyOtp,
          ),
        ],
      ),
    );
  }
}
