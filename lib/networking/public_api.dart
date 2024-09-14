import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../managers/auth_mgr.dart';
import '../model/project.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

// GET
class PublicApi extends NetworkMgr {
  Response? response;
  String errorMsg = '';
  String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  List<Project>? projects;

  Future<void> getProject({
    required String projectId,
  }) async {
    try {
      response = await dio.get(
        ApiPath.public.project(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // GET
  Future<void> getProjects({
    String? name,
    int? to,
    int? from,
    String? bootcamp,
    String? type,
    int? rating,
  }) async {
    try {
      response = await dio.get(
        ApiPath.public.allProjects,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {
          'name': name,
          'to': to,
          'from': from,
          'bootcamp': bootcamp,
          'type': type,
          'rating': rating
        },
      );
      if (response == null) throw Exception('');
      var jsonList = response!.data['data']['projects'];

      List<Project> temp = [];
      for (var p in jsonList) {
        temp.add(Project.fromJson(p));
      }
      projects = temp;
    } catch (e) {
      errorMsg = '$e';
    }
  }
}
