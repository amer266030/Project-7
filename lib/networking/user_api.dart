import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/model/api_response.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/networking/_client/network_mgr.dart';
import 'package:tuwaiq_project_pulse/utils/img_converter.dart';

import '../managers/auth_mgr.dart';
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
      {required String projectId, required AssetImage img}) async {
    var convertedImg = await ImgConverter.assetImgToIntList(img);
    try {
      var response = await dio.put(
        ApiPath.user.editProjectLogo(projectId: projectId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: jsonEncode({"logo": convertedImg}),
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
      print(ApiPath.user.editProjectBase(projectId: project.projectId ?? ''));

      var response = await dio.put(
        ApiPath.user.editProjectBase(projectId: project.projectId ?? ''),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          "project_name": "Donald Duck",
          "bootcamp_name": "Disney Land",
          "type": "website",
          "start_date": "15/09/2024",
          "end_date": "15/04/2025",
          "presentation_date": "15/04/2025",
          "project_description": "A movie about a sailor duck"
        },
      );
      setProject(response);
      print('Project Updated');
    } on DioException catch (e) {
      errorMsg = '${e.response.toString()}';
    } catch (e) {
      print(e);
    }
  }

  // PUT
  Future<void> createProjectPresentation() async {
    /* Data

    {
      "presentation_file":[1,2,3,4]
    }

     */
  }

  // PUT
  Future<void> createImages() async {
    /* Data

    {
      "images": [
        [1,2,3,4],
        [1,2,3,4],
        [1,2,3,4]
      ]
    }

     */
  }

  // PUT
  Future<void> createLinks({required String projectId}) async {
    try {
      print(ApiPath.user.editProjectLink(projectId: projectId));

      var response = await dio.put(
          ApiPath.user.editProjectLink(projectId: projectId),
          options:
              Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
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
    } catch (e) {
      print(e);
    }
  }

  // PUT
  Future<void> createMembers({required String projectId}) async {
    try {
      print(ApiPath.user.editProjectMembers(projectId: projectId));

      var response = await dio.put(
          ApiPath.user.editProjectMembers(projectId: projectId),
          options:
              Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
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
    } catch (e) {
      print(e);
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
