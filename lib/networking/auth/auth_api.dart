import 'package:flutter/foundation.dart';
import 'package:tuwaiq_project_pulse/networking/_client/api_path.dart';

import '../_client/network_mgr.dart';

mixin AuthApi on NetworkMgr {
  var path = ApiPath.auth;

  // Create User
  Future<void> createUser({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    var response = await dio.post(path.createAccount,
        data: {"email": email, "f_name": firstName, "l_name": lastName});
    if (kDebugMode) {
      print(response);
    }
  }
  // Login

  // OTP
}
