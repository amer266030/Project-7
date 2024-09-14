import 'dart:convert';

Account linkFromJson(String str) => Account.fromJson(json.decode(str));

String linkToJson(Account data) => json.encode(data.toJson());

class Account {
  String? github;
  String? linkedin;
  String? resume;
  String? bindlink;

  Account({
    this.github,
    this.linkedin,
    this.resume,
    this.bindlink,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        github: json["github"],
        linkedin: json["linkedin"],
        resume: json["resume"],
        bindlink: json["bindlink"],
      );

  Map<String, dynamic> toJson() => {
        "github": github,
        "linkedin": linkedin,
        "resume": resume,
        "bindlink": bindlink,
      };
}
