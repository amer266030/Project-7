import '../user/account.dart';

class ProjectMembers {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? position;
  String? imageUrl;
  String? resumeUrl;
  Account? account;

  ProjectMembers({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.position,
    this.imageUrl,
    this.resumeUrl,
    this.account,
  });

  factory ProjectMembers.fromJson(Map<String, dynamic> json) => ProjectMembers(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        position: json["position"],
        imageUrl: json["image_url"],
        resumeUrl: json["resume_url"],
        account: json["link"] == null
            ? null
            : Account.fromJson(json["link"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "position": position,
        "image_url": imageUrl,
        "resume_url": resumeUrl,
        "link": account?.toJson(),
      };
}
