import 'package:get_storage/get_storage.dart';

import '../model/auth.dart';

class AuthMgr {
  AuthData? authData;
  final box = GetStorage();
  final key = 'authData';

  AuthMgr() {
    fetchData();
  }

  fetchData() async {
    authData = await loadAuthData();
  }

  Future<AuthData?> loadAuthData() async {
    if (box.hasData(key)) {
      return AuthData.fromJson(
          Map.from(await box.read(key)).cast<String, dynamic>());
    }
    return null;
  }

  Future<void> saveAuth({required AuthData authData}) async {
    this.authData = authData;
    await box.write(key, authData.toJson());
  }

  Future<void> logOut() async {
    authData = null;
    await box.remove(key);
  }
}
