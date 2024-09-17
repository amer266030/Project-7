import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';

import '../managers/auth_mgr.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

class SupervisorApi extends NetworkMgr {
  var errorMsg = '';
  // POST
  Future<void> createProject({
    required String userId,
    required DateTime endDate, // DD/MM/YYYY
    required bool edit,
  }) async {
    try {
      var response = await dio.post(
        ApiPath.supervisor.createProject,
        options:
            Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
        data: {
          "user_id": userId,
          "time_end_edit": endDate.toFormattedString(),
          "edit": edit
        },
      );
    } on DioException catch (e) {
      errorMsg = '${e.response.toString()}';
    } catch (e) {
      print(e);
    }
  }

  // PUT
  Future<void> updateProject({
    required String projectId,
    required DateTime endDate, // DD/MM/YYYY
    required bool canEdit,
    required bool canRate,
    required bool isPublic,
  }) async {
    var response = await dio.put(
      ApiPath.supervisor.changeStatus(projectId: projectId),
      options:
          Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
      data: {
        "time_end_edit": "11/12/2024",
        "edit": canEdit,
        "rating": canRate,
        "public": isPublic
      },
    );
    if (kDebugMode) {
      print(response);
    }
  }

  // DELETE
  Future<void> deleteProject({
    required String projectId,
    required DateTime endDate, // DD/MM/YYYY
    required bool canEdit,
    required bool isPublic,
  }) async {
    var response = await dio.delete(
      ApiPath.supervisor.deleteProject(projectId: projectId),
      options:
          Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
      data: {
        {
          "time_end_edit": endDate.toFormattedString(),
          "allow_edit": canEdit,
          "is_public": isPublic
        }
      },
    );
    if (kDebugMode) {
      print(response);
    }
  }
}
