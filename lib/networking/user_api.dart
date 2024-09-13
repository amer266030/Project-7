import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/networking/_client/network_mgr.dart';

import '../model/rating.dart';
import '_client/api_path.dart';

class UserApi extends NetworkMgr {
  //POST
  Future<void> createRating(
      {required String projectId, required Rating rating}) async {
    var response = await dio.post(
      ApiPath.user.createRating(projectId: projectId),
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
  }

  // TODO: - Create Logo
  // PUT
  Future<void> createLogo(
      {required String projectId, required Image img}) async {}

  // TODO: - Create Project Base
  // PUT
  Future<void> createProjectBase() async {
    /* Data

    {
      "project_name": "Amazing Flutter App",
      "bootcamp_name": "Flutter Bootcamp 2024",
      "type": "website",
      "start_date": "15/12/2024",
      "end_date": "15/12/2024",
      "presentation_date": "15/12/2024",
      "project_description": "An amazing Flutter app that revolutionizes user experience."
    }

    */
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
  Future<void> createLinks() async {
    /* Data

    {
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
    }

     */
  }

  // TODO: - Create Members
  // PUT
  Future<void> createMembers() async {
    /* Data

    {
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
    }

     */
  }
}
