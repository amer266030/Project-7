import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

// GET
class PublicApi extends NetworkMgr {
  Response? response;

  Future<void> getProject({
    required String projectId,
  }) async {
    response = await dio.get(ApiPath.public.project(projectId: projectId));
    if (kDebugMode) {
      print(response);
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
    response = await dio.get(
      ApiPath.public.allProjects,
      queryParameters: {
        'name': name,
        'to': to,
        'from': from,
        'bootcamp': bootcamp,
        'type': type,
        'rating': rating
      },
    );
    if (kDebugMode) {
      print(response);
    }
  }
}
