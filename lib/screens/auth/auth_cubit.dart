import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/bottom_nav_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final nwk = NetworkingApi();
  AuthCubit() : super(AuthInitial());
  var isOtp = false;
  var isSignup = false;
  var emailController = TextEditingController();
  var firstNameController = TextEditingController(text: 'John');
  var lastNameController = TextEditingController(text: 'Doe');
  int otp = -1;

  String headerTitle() => isOtp
      ? 'Verify OTP'
      : isSignup
          ? 'Sign Up'
          : 'Sign In';

  void navigateToHome(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavScreen()));

  void toggleIsSignup() {
    isSignup = !isSignup;
    emit(AuthUpdateState());
  }

  void signUp() async {
    var email = emailController.text;
    var fName = firstNameController.text;
    var lName = lastNameController.text;
    await nwk.createUser(email: email, firstName: fName, lastName: lName);
  }

  void signIn() async {
    var email = emailController.text;
    await nwk.login(email: email);
  }

  void verifyOtp() async {
    var email = emailController.text;
    await nwk.verifyOTP(email: email, otp: otp);
  }
}
