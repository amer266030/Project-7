import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? firstName;
  String? lastName;
  List<int>? image;
  List<int>? cv;
  Accounts? accounts;

  User({
    this.firstName,
    this.lastName,
    this.image,
    this.cv,
    this.accounts,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"] == null
            ? []
            : List<int>.from(json["image"]!.map((x) => x)),
        cv: json["cv"] == null ? [] : List<int>.from(json["cv"]!.map((x) => x)),
        accounts: json["accounts"] == null
            ? null
            : Accounts.fromJson(json["accounts"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "cv": cv == null ? [] : List<dynamic>.from(cv!.map((x) => x)),
        "accounts": accounts?.toJson(),
      };
}

class Accounts {
  String? bindlink;
  String? linkedin;
  String? github;

  Accounts({
    this.bindlink,
    this.linkedin,
    this.github,
  });

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
        bindlink: json["bindlink"],
        linkedin: json["linkedin"],
        github: json["github"],
      );

  Map<String, dynamic> toJson() => {
        "bindlink": bindlink,
        "linkedin": linkedin,
        "github": github,
      };
}
