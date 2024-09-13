import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

class AdminApi extends NetworkMgr {
  Response? response;
  // PUT
  Future<void> changeUserRole({
    required String userId,
    required String role,
  }) async {
    response = await dio.put(ApiPath.admin.changeUserRole,
        data: {"id_user": userId, "role": role});
    if (kDebugMode) {
      print(response);
    }
  }
}
