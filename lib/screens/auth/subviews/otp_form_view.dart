import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class OtpFormView extends StatelessWidget {
  const OtpFormView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      textStyle: const TextStyle(
          fontSize: 24, color: Colors.blue, fontWeight: FW.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.orange),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white38,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child:
                Text('Please enter the verification code sent to your email')),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextButton(
            onPressed: cubit.toggleIsOTP,
            child: const Text('Cancel', style: TS(color: Colors.blue)),
          ),
        ),
      ],
    );
  }
}
