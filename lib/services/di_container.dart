import 'package:get_storage/get_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuwaiq_project_pulse/utils/shared_theme.dart';

import '../managers/auth_mgr.dart';

class DIContainer {
  static Future<void> setup() async {
    await GetStorage.init();
    sharedPreferences = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<AuthMgr>(AuthMgr());
  }
}
