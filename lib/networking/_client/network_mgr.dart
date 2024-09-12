import 'package:dio/dio.dart';

enum EndPoint { auth, user, admin, supervisor }

abstract class NetworkMgr {
  var dio = Dio();
  static const String baseUrl = 'https://tuwaiq-gallery.onrender.com/v1';
}
