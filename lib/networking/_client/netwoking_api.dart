import 'package:tuwaiq_project_pulse/networking/profile_api.dart';

import '../auth_api.dart';
import 'network_mgr.dart';
import '../profile_api.dart';

class NetworkingApi extends NetworkMgr with AuthApi, ProfileApi {}
