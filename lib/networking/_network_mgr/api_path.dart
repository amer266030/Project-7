class ApiPath {
  static var auth = _AuthPaths();
  static var user = _UserPaths();
  static var admin = _AdminPaths();
  static var supervisor = _Supervisor();
  static var public = _Public();
}

class _AuthPaths {
  final String postCreate = 'create/new/account';
  final String postLogin = 'login';
  final String postVerify = 'verify';
}

class _UserPaths {
  final String getProfile = 'profile';
  final String editProfile = 'update/profile';
  String editProjectLogo({required String projectId}) =>
      'edit/project/logo/$projectId';

  String editProjectBase({required String projectId}) =>
      'edit/project/base/$projectId';

  String editProjectPresentation({required String projectId}) =>
      'edit/project/presentation/$projectId';

  String editProjectImages({required String projectId}) =>
      'edit/project/images/$projectId';

  String editProjectLink({required String projectId}) =>
      'edit/project/link/$projectId';

  String editProjectMembers({required String projectId}) =>
      'project/members/$projectId';
}

class _AdminPaths {
  final String changeUserRole = '/change/role/user';
}

class _Supervisor {
  final String createProject = 'create/project';
  String changeStatus({required String projectId}) =>
      'change/status/$projectId';
  String deleteProject({required String projectId}) =>
      'delete/project/$projectId';
}

class _Public {
  String project({required String projectId}) => 'project/$projectId';
  final String allProjects = 'search/projects';
}
