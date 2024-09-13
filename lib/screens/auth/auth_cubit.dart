import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/bottom_nav/bottom_nav_screen.dart';

import '../../model/auth.dart';
import '../../reusable_components/custom_alert_dialog.dart';

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

  AuthCubit() : super(AuthInitial());

  String headerTitle() => isOtp
      ? 'Verify OTP'
      : isSignup
          ? 'Sign Up'
          : 'Sign In';

  void showAlert(BuildContext context) {
    dismissPreviousAlert(context);
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: alertTitle,
          msg: alertMsg,
          callback: () {
            Navigator.of(context, rootNavigator: true).pop();
            isAlertVisible = false; // Mark alert as dismissed
          },
        );
      },
    ).then((_) => isAlertVisible = false);
    isAlertVisible = true;
  }

  void dismissPreviousAlert(BuildContext context) {
    if (isAlertVisible) {
      Navigator.of(context).pop();
      isAlertVisible = false;
    }
  }

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
    emit(AuthLoadingState());
    try {
      await nwk.createUser(email: email, firstName: fName, lastName: lName);
      toggleIsOTP();
      emit(OTPState());
    } catch (e) {
      if (e is DioException) {
        alertTitle = 'Status Code: ${e.response?.statusCode}';
        alertMsg = 'Error Message: ${e.message}';
        emit(AuthErrorState());
      } else {
        alertTitle = '';
        alertMsg = 'Something wrong happened!, please try again later';
        emit(AuthErrorState());
      }
    }
  }

  void signIn() async {
    var email = emailController.text;
    clearAlertFields();
    emit(AuthLoadingState());
    try {
      await nwk.login(email: email);
      if (nwk.response?.statusCode != null) {
        if (nwk.response!.statusCode! > 199 &&
            nwk.response!.statusCode! < 300) {
          toggleIsOTP();
          emit(OTPState());
        }
      }
    } catch (e) {
      if (e is DioException) {
        alertTitle = 'Status Code: ${e.response?.statusCode}';
        alertMsg = 'Error Message: ${e.message}';
        emit(AuthErrorState());
      } else {
        alertTitle = '';
        alertMsg = 'Something wrong happened!, please try again later';
        emit(AuthErrorState());
      }
    }
  }

  void verifyOtp() async {
    var email = emailController.text;
    clearAlertFields();
    emit(AuthLoadingState());
    try {
      await nwk.verifyOTP(email: email, otp: otp);
      alertTitle = 'Status Code: ${nwk.response?.statusCode}';
      alertMsg = 'Account verified. Loading home screen...';
      var storageData = AuthData.fromJson(nwk.response?.data["data"]);
      authMgr.saveAuth(authData: storageData);
      emit(AuthSuccessState());
    } catch (e) {
      if (e is DioException) {
        alertTitle = 'Status Code: ${e.response?.statusCode}';
        alertMsg =
            'There was an error verifying your PIN. Please make sure you entered it correctly';
        emit(AuthErrorState());
      } else {
        alertTitle = '!';
        alertMsg = 'Something wrong happened!, please try again later';
        emit(AuthErrorState());
      }
    }
  }
}
