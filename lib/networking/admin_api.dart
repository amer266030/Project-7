import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../managers/auth_mgr.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

class AdminApi extends NetworkMgr {
  var authMgr = GetIt.I.get<AuthMgr>();
  String errorMsg = '';
  // PUT
  Future<void> changeUserRole({
    required String userId,
    required String role,
  }) async {
    try {
      var response = await dio.put(ApiPath.admin.changeUserRole,
          options: Options(headers: {
            'Authorization': 'Bearer ${authMgr.authData?.token ?? ''}'
          }),
          data: {"id_user": userId, "role": role});
      if (kDebugMode) {
        print(response);
      }
    } on DioException catch (e) {
      errorMsg = '${e.response}';
      print(e.response);
    }
  }
}
