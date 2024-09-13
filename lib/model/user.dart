import 'dart:convert';
import 'link.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  dynamic imageUrl;
  Link? link;
  List<dynamic>? projects;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.imageUrl,
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
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        projects: json["projects"] == null
            ? []
            : List<dynamic>.from(json["projects"]!.map((x) => x)),
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
        "role": role,
        "image_url": imageUrl,
        "link": link?.toJson(),
        "projects":
            projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
