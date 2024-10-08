// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/model/project/project_links.dart';
import 'package:tuwaiq_project_pulse/model/project/project_members.dart';
import 'package:tuwaiq_project_pulse/model/project/project_images.dart';
import 'package:tuwaiq_project_pulse/model/project/project_type.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  String? projectId;
  ProjectType? type;
  String? projectName;
  String? bootcampName;
  String? startDate;
  String? endDate;
  String? presentationDate;
  String? projectDescription;
  String? logoUrl;
  String? presentationUrl;
  String? userId;
  String? adminId;
  String? timeEndEdit;
  bool? allowEdit;
  bool? allowRating;
  num? rating;
  bool? isPublic;
  String? createAt;
  String? updateAt;
  List<ProjectImages>? imagesProject;
  List<ProjectLinks>? linksProject;
  List<ProjectMembers>? membersProject;

  Project({
    this.projectId,
    this.type,
    this.projectName,
    this.bootcampName,
    this.startDate,
    this.endDate,
    this.presentationDate,
    this.projectDescription,
    this.logoUrl,
    this.presentationUrl,
    this.userId,
    this.adminId,
    this.timeEndEdit,
    this.allowEdit,
    this.allowRating,
    this.isPublic,
    this.rating,
    this.createAt,
    this.updateAt,
    this.imagesProject,
    this.linksProject,
    this.membersProject,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectId: json["project_id"],
        type: json["type"] != null ? projectTypeFromString(json["type"]) : null,
        projectName: json["project_name"],
        bootcampName: json["bootcamp_name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        presentationDate: json["presentation_date"],
        projectDescription: json["project_description"],
        logoUrl: json["logo_url"],
        presentationUrl: json["presentation_url"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        timeEndEdit: json["time_end_edit"],
        allowEdit: json["allow_edit"],
        allowRating: json["allow_rating"],
        isPublic: json["is_public"],
        rating: json["rating"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
        imagesProject: json["images_project"] == null
            ? []
            : (json["images_project"] as List<dynamic>)
                .map((x) => ProjectImages.fromJson(x as Map<String, dynamic>))
                .toList(),
        linksProject: json["links_project"] == null
            ? []
            : (json["links_project"] as List<dynamic>)
                .map((x) => ProjectLinks.fromJson(x as Map<String, dynamic>))
                .toList(),
        membersProject: json["members_project"] == null
            ? []
            : (json["members_project"] as List<dynamic>)
                .map((x) => ProjectMembers.fromJson(x as Map<String, dynamic>))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "type": type != null
            ? projectTypeToString(type!)
            : null, // Convert enum to string
        "project_name": projectName,
        "bootcamp_name": bootcampName,
        "start_date": startDate?.toDateTime().toFormattedString(),
        "end_date": endDate?.toDateTime().toFormattedString(),
        "presentation_date": presentationDate?.toDateTime().toFormattedString(),
        "project_description": projectDescription,
        "logo_url": logoUrl,
        "presentation_url": presentationUrl,
        "user_id": userId,
        "admin_id": adminId,
        "time_end_edit": timeEndEdit,
        "allow_edit": allowEdit,
        "rating": rating,
        "allow_rating": allowRating,
        "is_public": isPublic,
        "create_at": createAt,
        "update_at": updateAt,
        "images_project": imagesProject == null
            ? []
            : List<dynamic>.from(imagesProject!.map((x) => x.toJson())),
        "links_project": linksProject == null
            ? []
            : List<dynamic>.from(linksProject!.map((x) => x.toJson())),
        "members_project": membersProject == null
            ? []
            : List<dynamic>.from(membersProject!.map((x) => x.toJson())),
      };
}
