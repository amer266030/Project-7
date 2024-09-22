import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/bottom_nav/bottom_nav_screen.dart';

import '../../extensions/color_ext.dart';
import '../../managers/alert_mgr.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final nwk = NetworkingApi.shared.authApi;
  final authMgr = GetIt.I.get<AuthMgr>();
  // Changing Forms
  var isOtp = false;
  var isSignup = false;
  // Input Fields
  var emailController = TextEditingController();
  var firstNameController = TextEditingController(text: 'John');
  var lastNameController = TextEditingController(text: 'Doe');
  int otp = -1;
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';

  Color flagPrimary = C.primary(context);
  Color flagBg1 = C.bg1(context);

  AuthCubit() : super(AuthInitial());

  changeColor() {
    flagPrimary = flagBg1;
    flagBg1 = flagPrimary;
    emit(AuthUpdateState(flagPrimary: flagPrimary, flagBg1: flagBg1));
  }

  String headerTitle() => isOtp
      ? 'Verify OTP'
      : isSignup
          ? 'Sign Up'
          : 'Sign In';

  void showAlert(BuildContext context, bool withDismiss) {
    dismissAlert(context);
    AlertManager().showAlert(
      context: context,
      title: alertTitle,
      message: alertMsg,
      withDismiss: withDismiss ? true : false,
    );
  }

  void dismissAlert(BuildContext context) =>
      AlertManager().dismissPreviousAlert(context);

  void navigateToHome(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavScreen()));

  void toggleIsSignup() {
    isSignup = !isSignup;
    emit(AuthUpdateState());
  }

  void toggleIsOTP() {
    isOtp = !isOtp;
    emit(AuthUpdateState());
  }

  void clearAlertFields() {
    alertTitle = '';
    alertMsg = '';
  }

  void signUp() async {
    var email = emailController.text;
    var fName = firstNameController.text;
    var lName = lastNameController.text;
    clearAlertFields();
    alertMsg = 'Creating Account';
    emit(AuthLoadingState());
    try {
      await nwk.createUser(email: email, firstName: fName, lastName: lName);
      toggleIsOTP();
      emit(OTPState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(AuthErrorState());
    }
  }

  void signIn() async {
    var email = emailController.text;
    clearAlertFields();
    alertMsg = 'Loading Profile';
    emit(AuthLoadingState());
    try {
      await nwk.login(email: email);
      toggleIsOTP();
      emit(OTPState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(AuthErrorState());
    }
  }

  void verifyOtp() async {
    var email = emailController.text;
    clearAlertFields();
    emit(AuthLoadingState());
    try {
      await nwk.verifyOTP(email: email, otp: otp);
      if (authMgr.authData == null) throw Exception(nwk.errorMsg);
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthSuccessState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(AuthErrorState());
    }
  }
}
