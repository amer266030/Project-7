import 'package:flutter/foundation.dart';

import '../model/user.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

mixin ProfileApi on NetworkMgr {
  Future<void> fetchProfile() async {
    var response = await dio.get(ApiPath.user.getProfile);
    if (kDebugMode) {
      print(response);
    }
  }

  Future<void> updateProfile(User user) async {
    var response = await dio.put(ApiPath.user.editProfile, data: {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "image": user.image,
      "cv": user.cv,
      "accounts": {
        "bindlink": user.accounts?.bindlink,
        "linkedin": user.accounts?.linkedin,
        "github": user.accounts?.github
      }
    });
    if (kDebugMode) {
      print(response);
    }
  }
}
