import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/networking/_client/network_mgr.dart';
import 'package:tuwaiq_project_pulse/utils/img_converter.dart';

import '../managers/auth_mgr.dart';
import '../model/rating.dart';
import '_client/api_path.dart';

class UserApi extends NetworkMgr {
  //String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  String token =
      "OTZmYjM1YmRmZjQxYWNmMWEwNDQ4NTc0N2JiNDFmMTNkMjk4NTBjMTQ4YzUyNDdkZDY3YTI2NTE1ZDZjOTU4M2Y1NWI0NzkzODMyYzQyYzk4OWJiYTY0ZGQ5Mjc2YWI2OTYxZDRkYWZlZTY5ZjQ1YzIzNjI1Y2I0ODRiZmE4ZTQ3ZWVhNDcyZDg0YzA3YTIyOTNiZDA3NWU2MjMxOTMxZDQyMmI4MmY4NWUzMGI4Yzc2YzU5Y2VmNGFlM2U1YzY0MTQ4Yzc5MjViOTRhOGZmYWY1OTUzYzU5Y2ZjMTJmZjdkZGRlZDNjOTk3NjcxMzY0MjE0NzI0NWYxYTNiM2JhY2IwNjZjYmFjMzJmMmE4ZjcyMDIyZDM0NDcxZDhhNzY4MmE4Nzg3YjZmODM4MTViZTQ0N2QyM2U5N2NmMThiYTNhODhkYTliMDZiNmIwNmI5YjZjYTI0NGY5NzUyMDk3NzA3YjNjY2Q3ODU3NzlkYTFlMzE3YWViMmRmZTU1MzM3MzI2NjBjNGMxM2FiNTNlMTVlZDc1NDVhNjRlODMxYjUzZDk5YmI5NTA4YTM0YjIwM2IwNjY3YzA1MmMwZWY3ODY2MWQyOThiMTQ2YzgwOTQyYzdhMWQ3ZTgxZDczYWNiMDAzNDAwNjYwYjBhZGU4ZGU2MGY4YjA1MGVhZTdjNGE5MmUzYmRkNWU5ZDM3MzBiY2RkNDgyZDE0N2U0N2E0YzhhMmUxYzQwNzQwOTQwOGNlYzc5MTIzMWQzN2QxMzA5Njg3MzBlMDg5ODliMDFjZGUwOTIwYjE1Y2ZlNjZjZDJlMGUxM2ZkYWM1NmJkZGY4MDVjOTFjMDk0ZjVlYTVmNGQyMTQ3NDg3YjVmZWEzZjcxZDA5MWY0MTliMTBjOWRlODc1ZWJjOWQzMGU2MjkzNzNmMzg0MGVhOTBhODlkODUwYzEyYjM2ZDZjNThmZWRlNTZhNjA1YTdlYTUxYmY3ZjJlNmZmNjc0YWJlOTJhMDJkZTNkNjRmNDQ3NDQ0MjQwMjFjMDgxNTMzZDIwN2M4MDlhYWZkNTgxZjFkMjJjZGFhN2M4Mjc2ODAzMGQ1ZjIzNWIzZDc2OGUzNzgxNjcwMGI5NDRhY2JkZjFiNDk2MzhjNGQ1Yzc0Y2ViYTA2YWQ2Mzc3NTYxYTYwYzlkY2IyMzI1OGI0ODA4ODVkZWQ5NmVjY2JkZDQ4MjkxNDllNmU0MzZjY2MyYmIyZWYwYWVkZDgxZDMzZGM0MTM5OTcwMTI0ZmRmMTgyMDdhOWYyNGVhYTU2YjVjNzYyZDE5NWI4OGI1OGE3ZGIxZDgzNjY3ZGFkZTA3OGU1OTliZmIxOGM2M2M3Yzc4M2Y4NjNjNGFjNGI2NGExODIzNmU3M2ViNDYwM2QzNWZkOTFmNWMxOTYwN2UxMzczYWY3Y2I1ZTU4YmRjY2VjNWIxMDEyNzUzZTc4MDAyNzhlMzc3NmJmNzcwNDE3ZWRlM2YwYWY0ZWFiNjRjYmM3ZjY0Zjc4YjQ2NGMwNTRmMjAxZmNiZTY0YzJhMTJmMjQyODI4M2QwMGJjYTIzMDIzYTgxNmViZWUwNTYwN2E3NTA1OGJiMDNkOWM0YWQ1YzczMzU0ZmE5MjQ3ZjlhOGJiY2QwMDE1ZTgzNGQ3ZDc5NjYyYzYwYmJhMjgzNDIyMzlkNGEzMTkyMWFjNjZlZGQ5OTdiNTQwYTQzNmZmOWQzYjNlNmM2M2I4NjFlMzQ4NjM0MjgwYTkwNzEyYTAwZjUwNGZmNjZhMmYzMTU3MzlkNDRkMjJhYmFjMzU1NTNhMTExOGU4NDM5NzM2MWIxNWVlMWVkOTc4YWYzNDIxZWVmN2YzOGRkODcxMjAyNDNmYmQwZGNhOThiZGE0MGJmOGU4MTg1MGZjMmZlOWY4MjNlN2U3MjU4MzZlNjQxZjM2ZWM3YzZjNDcwMTBmM2MxN2I5OTY4M2RiM2E0ZTMwYzBkYmU1ZThlZWExMWQ5NWQ5NzlkZGFmZGZlOTBlODIxMjc4Y2Y0ZTEyZmViMTUxODJhOGFjMWZjZGJhZDk0NTQ4MmY5MmI4Nzc4NjQxYWFkNjE0MzIxNDMxMTY3NzEzNGQ0YjY2YTJjOGFiYjc1ZWNhNDg1MzMyZDYyMmNkMGQwNmFhMmY3MmVkZGYzZjM4YTQ0NmYzMmQ2ODczNjk1M2YyN2ZkMWFkOTI4MzIyNjY0NGZhN2UzMzZlMGM2YWIzMWQ1ZmQ";
  //POST
  Future<void> createRating(
      {required String projectId, required Rating rating}) async {
    try {
      var response = await dio.post(
        ApiPath.user.createRating(projectId: projectId),
        options:
            Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
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
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // TODO: - Create Logo
  // PUT
  Future<void> createLogo(
      {required String projectId, required AssetImage img}) async {
    var convertedImg = await ImgConverter.assetImgToBytes(img);
    print(convertedImg);
    try {
      print(ApiPath.user.editProjectLogo(projectId: projectId));
      print(
          " https://tuwaiq-gallery.onrender.com/v1/user/edit/project/logo/p-JGqY6xjCAK");
      final img = await ImgConverter.assetImgToBase64(
          const AssetImage('assets/defaultImg.png'));
      var response = await dio.put(
        ApiPath.user.editProjectLogo(projectId: projectId),
        options:
            Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
        queryParameters: {"logo": convertedImg},
        data: {
          "logo": [1, 2, 3, 4]
        },
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  // TODO: - Create Project Base
  // PUT
  Future<void> createProjectBase({required String projectId}) async {
    try {
      print(ApiPath.user.editProjectBase(projectId: projectId));

      var response = await dio.put(
        ApiPath.user.editProjectBase(projectId: projectId),
        options:
            Options(headers: {'Authorization': 'Bearer ${AuthMgr.adminKey}'}),
        data: {
          "project_name": "Amazing Flutter App",
          "bootcamp_name": "Flutter Bootcamp 2024",
          "type": "website",
          "start_date": "15/12/2024",
          "end_date": "15/12/2024",
          "presentation_date": "15/12/2024",
          "project_description":
              "An amazing Flutter app that revolutionizes user experience."
        },
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  // TODO: - Project Presentation
  // PUT
  Future<void> createProjectPresentation() async {
    /* Data

    {
      "presentation_file":[1,2,3,4]
    }

     */
  }

  // TODO: - Create Images
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

  // TODO: - Create Links
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
      print(response);
    } catch (e) {
      print(e);
    }
  }

  // TODO: - Create Members
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
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
