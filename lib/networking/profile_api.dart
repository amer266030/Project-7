import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';

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
    } catch (e) {
      errorMsg = e.toString();
    }
  }

  Future<void> updateProfile(User user) async {
    print('In the api method!');
    print(user.toJson());
    try {
      var response = await dio.put(
        ApiPath.user.editProfile,
        data: user.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer ${authMgr.authData?.token}'},
        ),
      );
      print(response.data);
      await setUser(response);
    } on DioException catch (e) {
      errorMsg = e.response.toString();
      print(e.response);
    } catch (e) {
      errorMsg = e.toString();
      print(e);
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
      }
    }
  }
}
