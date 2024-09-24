import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';

import '../managers/auth_mgr.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

class SupervisorApi extends NetworkMgr {
  var authMgr = GetIt.I.get<AuthMgr>();
  String adminToken = AuthMgr.adminKey;
  var errorMsg = '';
  // POST
  Future<void> createProject({
    required String userId,
    required String endDate, // DD/MM/YYYY
    required bool edit,
  }) async {
    try {
      await dio.post(
        ApiPath.supervisor.createProject,
        options: Options(headers: {
          'Authorization': 'Bearer ${authMgr.authData?.token ?? ''}'
        }),
        data: {"user_id": userId, "time_end_edit": endDate, "edit": edit},
      );
    } on DioException catch (e) {
      errorMsg = '${e.response}';
      rethrow;
    } catch (e) {
      rethrow;
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
    try {
      var response = await dio.put(
        ApiPath.supervisor.changeStatus(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $adminToken'}),
        data: {
          "time_end_edit": endDate.toFormattedString(),
          "edit": canEdit,
          "rating": canRate,
          "public": isPublic
        },
      );
      if (kDebugMode) {
        print(response.data);
      }
    } on DioException catch (e) {
      errorMsg = '${e.response}';
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE
  Future<void> deleteProject({
    required String projectId,
    required String endDate, // DD/MM/YYYY
    required bool canEdit,
    required bool isPublic,
  }) async {
    try {
      var response = await dio.delete(
        ApiPath.supervisor.deleteProject(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $adminToken'}),
        data: {
          {
            "time_end_edit": endDate,
            "allow_edit": canEdit,
            "is_public": isPublic
          }
        },
      );
      if (kDebugMode) {
        print(response.data);
      }
    } on DioException catch (e) {
      errorMsg = '${e.response}';
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
