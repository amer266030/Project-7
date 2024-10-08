import 'dart:convert';
import 'package:tuwaiq_project_pulse/model/project/project.dart';

import 'account.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? imageUrl;
  String? resumeUrl;
  Account? link;
  List<Project>? projects;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.imageUrl,
    this.resumeUrl,
    this.link,
    this.projects,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        role: json["role"],
        imageUrl: json["image_url"],
        resumeUrl: json["resume_url"],
        link: json["link"] == null ? null : Account.fromJson(json["link"]),
        projects: json["projects"] == null
            ? []
            : List<Project>.from(
                json["projects"]!.map((x) => Project.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "image_url": imageUrl,
        "accounts": link?.toJson(),
      };
}
