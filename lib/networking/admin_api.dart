import 'package:flutter/foundation.dart';

import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

class AdminApi extends NetworkMgr {
  // PUT
  Future<void> changeUserRole({
    required String userId,
    required String role,
  }) async {
    var response = await dio.put(ApiPath.admin.changeUserRole,
        data: {"id_user": userId, "role": role});
    if (kDebugMode) {
      print(response);
    }
  }
}
