import 'package:dio/dio.dart';

abstract class NetworkMgr {
  var dio = Dio();
  String baseUrl = 'https://tuwaiq-gallery.onrender.com/v1';
  String endPointPath({
    APIVersion apiVersion = APIVersion.v1,
    required EndPoint endPoint,
    required String path,
  }) {
    return '$baseUrl/${apiVersion.name}/${endPoint.name}/${path}';
  }
}

enum APIVersion { v1 }

enum EndPoint { auth, user, admin, supervisor, project, search }
