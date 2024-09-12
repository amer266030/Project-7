import 'package:get_storage/get_storage.dart';

import '../model/auth.dart';

class AuthMgr {
  AuthData? auth;
  final box = GetStorage();
  final key = 'auth';

  saveAuth({required AuthData auth}) {
    auth = auth;
    // box.write(key: auth.toJson());
  }

  loadAuthData() async {
    var response = await box.read(key);
    if (response != null) {
      // auth = FromJson(response);
    } else {
      // No User Found!
    }
  }
}
