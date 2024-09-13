import 'dart:convert';

Link linkFromJson(String str) => Link.fromJson(json.decode(str));

String linkToJson(Link data) => json.encode(data.toJson());

class Link {
  String? bindlink;
  String? linkedin;
  String? github;

  Link({
    this.bindlink,
    this.linkedin,
    this.github,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
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
