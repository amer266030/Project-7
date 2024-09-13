import 'package:tuwaiq_project_pulse/networking/admin_api.dart';
import 'package:tuwaiq_project_pulse/networking/profile_api.dart';
import 'package:tuwaiq_project_pulse/networking/public_api.dart';
import 'package:tuwaiq_project_pulse/networking/supervisor_api.dart';
import 'package:tuwaiq_project_pulse/networking/user_api.dart';

import '../auth_api.dart';
import 'network_mgr.dart';

class NetworkingApi extends NetworkMgr
    with AdminApi, AuthApi, ProfileApi, PublicApi, SupervisorApi, UserApi {}
