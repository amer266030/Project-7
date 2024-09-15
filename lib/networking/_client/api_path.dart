import 'network_mgr.dart';

class ApiPath {
  static var auth = _AuthPaths();
  static var user = _UserPaths();
  static var admin = _AdminPaths();
  static var supervisor = _Supervisor();
  static var public = _Public();
}

class _AuthPaths extends NetworkMgr {
  static String prefix = '${NetworkMgr.baseUrl}/${EndPoint.auth.name}';

  final String createAccount = '$prefix/create/new/account';
  final String login = '$prefix/login';
  final String otpVerify = '$prefix/verify';
}

class _UserPaths {
  static String prefix = '${NetworkMgr.baseUrl}/${EndPoint.user.name}';
  // Profile
  final String getProfile = '$prefix/profile';
  final String editProfile = '$prefix/update/profile';
  // User
  String createRating({required String projectId}) =>
      '$prefix/rating/project/$projectId';

  String editProjectLogo({required String projectId}) =>
      '$prefix/edit/project/logo/$projectId';

  String editProjectBase({required String projectId}) =>
      '$prefix/edit/project/base/$projectId';

  String editProjectPresentation({required String projectId}) =>
      '$prefix/edit/project/presentation/$projectId';

  String editProjectImages({required String projectId}) =>
      '$prefix/edit/project/images/$projectId';

  String editProjectLink({required String projectId}) =>
      '$prefix/edit/project/link/$projectId';

  String editProjectMembers({required String projectId}) =>
      '$prefix/edit/project/members/$projectId';
}

class _AdminPaths {
  static String prefix = '${NetworkMgr.baseUrl}/${EndPoint.admin.name}';

  final String changeUserRole = '$prefix/change/role/user';
}

class _Supervisor {
  static String prefix = '${NetworkMgr.baseUrl}/${EndPoint.supervisor.name}';

  final String createProject = '$prefix/create/project';
  String changeStatus({required String projectId}) =>
      '$prefix/change/status/$projectId';
  String deleteProject({required String projectId}) =>
      '$prefix/delete/project/$projectId';
}

class _Public {
  static String prefix = NetworkMgr.baseUrl;

  String project({required String projectId}) =>
      '$prefix/get/project/$projectId';
  final String allProjects = '$prefix/projects';
}
