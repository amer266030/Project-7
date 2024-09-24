import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';
import 'package:tuwaiq_project_pulse/utils/img_converter.dart';

import '../model/api_response.dart';
import '../model/user/user.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

class ProfileApi extends NetworkMgr {
  String errorMsg = '';
  var authMgr = GetIt.I.get<AuthMgr>();
  User? user;

  // API Functions
  Future<void> fetchProfile() async {
    user = null;
    try {
      var response = await dio.get(
        ApiPath.user.getProfile,
        options: Options(
            headers: {'Authorization': 'Bearer ${authMgr.authData?.token}'}),
      );
      await setUser(response);
    } on DioException catch (e) {
      errorMsg = e.response.toString();
      rethrow;
    } catch (e) {
      errorMsg = e.toString();
      rethrow;
    }
  }

  Future<void> updateProfile({required User user, File? img, File? cv}) async {
    List<int>? imgToUpload;
    List<int>? fileToUpload;

    if (img != null) {
      imgToUpload = await ImgConverter.fileImgToIntList(img);
    }
    if (cv != null) {
      fileToUpload = await cv.readAsBytes();
    }

    // Create a map for the data
    Map<String, dynamic> data = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "accounts": {
        "bindlink": user.link?.bindlink,
        "linkedin": user.link?.linkedin,
        "github": user.link?.github,
      },
    };

    if (imgToUpload != null) {
      data["image"] = imgToUpload;
    }
    if (fileToUpload != null) {
      data["cv"] = fileToUpload;
    }

    try {
      await dio.put(
        ApiPath.user.editProfile,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${authMgr.authData?.token}'},
        ),
      );
    } on DioException catch (e) {
      print(e.response);
      errorMsg = '${e.response}';
      rethrow;
    } catch (e) {
      errorMsg = '$e';
      rethrow;
    }
  }

  Future<void> setUser(Response response) async {
    if (response.data == null) return;
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      var jsonMap = response.data!;
      try {
        ApiResponse<User> apiResponse = responseFromMap<User>(
          jsonMap,
          (dataJson) => User.fromJson(dataJson),
        );
        user = apiResponse.data;
        if (user != null) {
          await authMgr.saveUserData(user: user!);
        }
      } catch (e) {
        errorMsg = e.toString();
        rethrow;
      }
    }
  }
}
