import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';

import '../model/api_response.dart';
import '../model/user/user.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

class ProfileApi extends NetworkMgr {
  String errorMsg = '';
  String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  User? user;

  // API Functions
  Future<void> fetchProfile() async {
    try {
      var response = await dio.get(
        ApiPath.user.getProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      await setUser(response);
    } on DioException catch (e) {
      errorMsg = e.response.toString();
    } catch (e) {
      errorMsg = e.toString();
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      var response = await dio.put(
        ApiPath.user.editProfile,
        data: user.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      await setUser(response);
    } on DioException catch (e) {
      errorMsg = e.response.toString();
    } catch (e) {
      errorMsg = e.toString();
    }
  }

  // Function for setting the user variable.
  /// used in API Functions
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
      } catch (e) {
        errorMsg = e.toString();
      }
    }
  }
}
