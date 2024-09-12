import 'package:dio/dio.dart';

abstract class NetworkMgr {
  final dio = Dio();
  final String baseUrl = 'https://tuwaiq-gallery.onrender.com';
}

enum HttpMethod { get, post, put, delete }

enum EndPoint { auth, user, admin, supervisor, project, search }

enum HTTPAction { create, update, edit, change, delete }
