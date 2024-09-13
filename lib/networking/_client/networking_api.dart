import 'package:tuwaiq_project_pulse/networking/admin_api.dart';
import 'package:tuwaiq_project_pulse/networking/profile_api.dart';
import 'package:tuwaiq_project_pulse/networking/public_api.dart';
import 'package:tuwaiq_project_pulse/networking/supervisor_api.dart';
import 'package:tuwaiq_project_pulse/networking/user_api.dart';

import '../auth_api.dart';
import 'network_mgr.dart';

class NetworkingApi {
  // private constructor
  static final _shared = NetworkingApi._internal();

  final AdminApi adminApi;
  final AuthApi authApi;
  final ProfileApi profileApi;
  final PublicApi publicApi;
  final SupervisorApi supervisorApi;
  final UserApi userApi;

  NetworkingApi._internal()
      : adminApi = AdminApi(),
        authApi = AuthApi(),
        profileApi = ProfileApi(),
        publicApi = PublicApi(),
        supervisorApi = SupervisorApi(),
        userApi = UserApi();

  // singleton access
  static NetworkingApi get shared => _shared;
}
