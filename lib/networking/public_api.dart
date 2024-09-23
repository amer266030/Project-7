import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/mock_data_mgr.dart';
import 'package:tuwaiq_project_pulse/model/api_response.dart';
import 'package:tuwaiq_project_pulse/model/project/projects_response.dart';

import '../managers/auth_mgr.dart';
import '../model/project/project.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

// NOT TESTED!

// GET
class PublicApi extends NetworkMgr {
  String errorMsg = '';
  String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  List<Project>? projects;
  Project? project;
  var mockData = MockDataManager();

  Future<void> getProjectById({
    required String projectId,
  }) async {
    try {
      var response = await dio.get(
        ApiPath.public.project(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      setProject(response);
    } on DioException catch (e) {
      errorMsg = e.response.toString();
      rethrow;
    } catch (e) {
      errorMsg = e.toString();
      rethrow;
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
    if (mockData.isPreview) {
      projects = mockData.getMockProjects();
    } else {
      try {
        var response = await dio.get(
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
        setProjects(response);
      } on DioException catch (e) {
        errorMsg = e.response.toString();
        rethrow;
      } catch (e) {
        errorMsg = e.toString();
        rethrow;
      }
    }
  }

  Future<void> setProject(Response response) async {
    if (response.data == null) return;
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      var jsonMap = response.data!;
      try {
        ApiResponse<Project> apiResponse = responseFromMap<Project>(
          jsonMap,
          (dataJson) => Project.fromJson(dataJson),
        );
        project = apiResponse.data;
      } on DioException catch (e) {
        errorMsg = e.response.toString();
        rethrow;
      } catch (e) {
        errorMsg = e.toString();
        rethrow;
      }
    }
  }

  Future<void> setProjects(Response response) async {
    if (response.data == null) return;

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      var jsonMap = response.data! as Map<String, dynamic>;

      try {
        var apiResponse = responseFromMap(
          jsonMap,
          (dataJson) => ProjectsResponse.fromJson(dataJson),
        );
        var projectsResponse = apiResponse.data;
        projects = projectsResponse?.projects;
      } catch (e) {
        errorMsg = e.toString();
        rethrow;
      }
    }
  }
}
