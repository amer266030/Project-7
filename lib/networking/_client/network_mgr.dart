import 'package:dio/dio.dart';

abstract class NetworkMgr {
  var dio = Dio();
  static const String baseUrl = 'https://tuwaiq-gallery.onrender.com/v1';
}

enum EndPoint { auth, user, admin, supervisor }
