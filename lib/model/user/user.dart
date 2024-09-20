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
  String? createdAt;
  String? updatedAt;

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
        link: json["link"] == null
            ? null
            : Account.fromJson(json["link"] as Map<String, dynamic>),
        projects: json["projects"] == null
            ? []
            : (json["projects"] as List<dynamic>)
                .map((x) => Project.fromJson(x as Map<String, dynamic>))
                .toList(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "role": role,
        "image_url": imageUrl,
        "resume_url": resumeUrl,
        "link": link?.toJson(),
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
