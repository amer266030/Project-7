import 'package:flutter/foundation.dart';
import 'package:tuwaiq_project_pulse/networking/_client/api_path.dart';

import '_client/network_mgr.dart';

// NOT TESTED!

class AuthApi extends NetworkMgr {
  // POST
  Future<void> createUser({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    if (kDebugMode) {
      print(ApiPath.auth.createAccount);
    }
    var response = await dio.post(ApiPath.auth.createAccount,
        data: {"email": email, "f_name": firstName, "l_name": lastName});
    if (kDebugMode) {
      print(response);
    }
  }

  // POST
  Future<void> login({
    required String email,
  }) async {
    var response = await dio.post(ApiPath.auth.login, data: {"email": email});
    if (kDebugMode) {
      print(response);
    }
  }

  // POST
  Future<void> verifyOTP({
    required String email,
    required int otp, // 6 digit number
  }) async {
    var response = await dio
        .post(ApiPath.auth.otpVerify, data: {"email": email, "otp": '$otp'});
    if (kDebugMode) {
      print(response);
    }
  }
}
