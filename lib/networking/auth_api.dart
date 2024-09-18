import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/networking/_client/api_path.dart';

import '../managers/auth_mgr.dart';
import '../model/auth.dart';
import '_client/network_mgr.dart';

class AuthApi extends NetworkMgr {
  final authMgr = GetIt.I.get<AuthMgr>();
  String errorMsg = '';
  // POST
  Future<void> createUser({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await dio.post(ApiPath.auth.createAccount,
          data: {"email": email, "f_name": firstName, "l_name": lastName});
    } on DioException catch (e) {
      errorMsg = '${e.response.toString()}';
      print('Error $e');
    } catch (e) {
      errorMsg = '$e';
      print('Error $e');
    }
  }

  // POST
  Future<void> login({
    required String email,
  }) async {
    try {
      await dio.post(ApiPath.auth.login, data: {"email": email});
      print('Login Step');
    } on DioException catch (e) {
      errorMsg = '${e.response.toString()}';
      print('Error $e');
    } catch (e) {
      print('Error $e');
      errorMsg = '$e';
    }
  }

  // POST
  Future<void> verifyOTP({
    required String email,
    required int otp, // 6 digit number
  }) async {
    try {
      var response = await dio
          .post(ApiPath.auth.otpVerify, data: {"email": email, "otp": '$otp'});
      // Save Token
      var storageData = AuthData.fromJson(response.data["data"]);
      authMgr.saveAuth(authData: storageData);
    } on DioException catch (e) {
      errorMsg = '${e.response}';
    } catch (e) {
      errorMsg = '$e';
    }
  }
}
