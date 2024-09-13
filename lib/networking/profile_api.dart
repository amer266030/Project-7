import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';

import '../model/api_response.dart';
import '../model/user.dart';
import '_client/api_path.dart';
import '_client/network_mgr.dart';

class ProfileApi extends NetworkMgr {
  Response? response;
  String errorMsg = '';
  String token = GetIt.I.get<AuthMgr>().authData?.token ?? '';
  User? user;

  Future<void> fetchProfile() async {
    try {
      response = await dio.get(
        ApiPath.user.getProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response == null) throw Exception('No Response');
      await setUser(response!);
    } catch (e) {
      errorMsg = e.toString();
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      response = await dio.put(
        ApiPath.user.editProfile,
        data: user.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response == null) throw Exception('No Response');
      await setUser(response!);
    } catch (e) {
      errorMsg = e.toString();
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
      } catch (e) {
        errorMsg = e.toString();
      }
    }
  }
}
