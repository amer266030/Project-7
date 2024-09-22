import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/model/api_response.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/networking/_client/network_mgr.dart';
import 'package:tuwaiq_project_pulse/utils/img_converter.dart';

import '../managers/auth_mgr.dart';
import '../model/project/project_links.dart';
import '../model/rating.dart';
import '_client/api_path.dart';

class UserApi extends NetworkMgr {
  Project? project;
  String? errorMsg;

  String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  String adminToken = AuthMgr.adminKey;
  //POST
  Future<void> createRating(
      {required String projectId, required Rating rating}) async {
    try {
      var response = await dio.post(
        ApiPath.user.createRating(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          "idea": rating.idea,
          "design": rating.design,
          "tools": rating.tools,
          "practices": rating.practices,
          "presentation": rating.presentation,
          "investment": rating.investment,
          "note": rating.note
        },
      );
      if (kDebugMode) {
        setProject(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // PUT
  Future<void> createLogo(
      {required String projectId, required File img}) async {
    var imgToUpload = await ImgConverter.fileImgToIntList(img);
    try {
      await dio.put(
        ApiPath.user.editProjectLogo(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: jsonEncode({"logo": imgToUpload}),
      );
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }

  // PUT
  Future<void> createProjectBase({required Project project}) async {
    try {
      var response = await dio.put(
        ApiPath.user.editProjectBase(projectId: project.projectId ?? ''),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          "project_name": project.projectName,
          "bootcamp_name": project.bootcampName,
          "type": project.type!.name,
          "start_date": project.startDate,
          "end_date": project.endDate,
          "presentation_date": project.presentationDate,
          "project_description": project.projectDescription
        },
      );
      setProject(response);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }

  // PUT
  Future<void> createProjectPresentation(
      {required String projectId, required File presentation}) async {
    List<int>? fileToUpload = await presentation.readAsBytes();

    try {
      var response = await dio.put(
        ApiPath.user.editProjectPresentation(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"presentation_file": fileToUpload},
      );
      setProject(response);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }

  // PUT
  Future<void> createImages(
      {required String projectId, required List<File> fileImages}) async {
    List<List<int>> imagesToUpload = [];

    if (fileImages.isNotEmpty) {
      for (var img in fileImages) {
        imagesToUpload.add(await ImgConverter.fileImgToIntList(img));
      }
    }

    try {
      var response = await dio.put(
        ApiPath.user.editProjectImages(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"images": imagesToUpload},
      );
      setProject(response);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }

  // PUT
  Future<void> createLinks(
      {required String projectId, required ProjectLinks links}) async {
    try {
      var response = await dio.put(
          ApiPath.user.editProjectLink(projectId: projectId),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            "link": [
              {"type": "github", "url": "https://github.com/example"},
              {"type": "figma", "url": "https://figma.com/example"},
              {"type": "video", "url": "https://youtube.com/example"},
              {"type": "pinterest", "url": "https://appstore.com/example"},
              {"type": "playstore", "url": "https://appstore.com/example"},
              {"type": "applestore", "url": "https://appstore.com/example"},
              {"type": "apk", "url": "https://appstore.com/example"},
              {"type": "weblink", "url": "https://appstore.com/example"}
            ]
          });
      setProject(response);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }

  // PUT
  Future<void> createMembers({required String projectId}) async {
    try {
      print(ApiPath.user.editProjectMembers(projectId: projectId));

      var response = await dio.put(
          ApiPath.user.editProjectMembers(projectId: projectId),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            "members": [
              {
                "position": "ui",
                "user_id": "6ca9bc46-217e-48ed-9fde-4b0ff57ad4b6"
              },
              {
                "position": "Developer",
                "user_id": "edc41350-526e-40af-97be-2e32a78d55bd"
              },
              {
                "position": "Developer",
                "user_id": "10545b55-4875-441d-88e8-f835acc72374"
              }
            ]
          });
      setProject(response);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
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
      } catch (e) {
        errorMsg = e.toString();
      }
    }
  }
}
