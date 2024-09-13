import 'dart:convert';

ApiResponse<T> responseFromJson<T>(
        String str, T Function(Map<String, dynamic>) fromJsonT) =>
    ApiResponse<T>.fromJson(json.decode(str), fromJsonT);

String responseToJson<T>(ApiResponse<T> data) => json.encode(data.toJson());

ApiResponse<T> responseFromMap<T>(
        Map<String, dynamic> map, T Function(Map<String, dynamic>) fromJsonT) =>
    ApiResponse<T>.fromJson(map, fromJsonT);

class ApiResponse<T> {
  String? msg;
  T? data;

  ApiResponse({
    this.msg,
    this.data,
  });

  // Factory constructor to create an ApiResponse from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json,
          T Function(Map<String, dynamic>) fromJsonT) =>
      ApiResponse<T>(
        msg: json["msg"],
        data: json["data"] == null ? null : fromJsonT(json["data"]),
      );

  // Method to convert ApiResponse to JSON
  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data == null ? null : (data as dynamic).toJson(),
      };
}
