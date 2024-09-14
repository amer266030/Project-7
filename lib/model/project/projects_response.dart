import 'package:tuwaiq_project_pulse/model/project/project.dart';

class ProjectsResponse {
  int? count;
  List<Project>? projects;

  ProjectsResponse({
    this.count,
    this.projects,
  });

  // Factory constructor to create ProjectsResponse from JSON
  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      count: json['count'],
      projects: json['projects'] != null
          ? List<Project>.from(
              json['projects'].map((project) => Project.fromJson(project)))
          : null,
    );
  }

  // Method to convert ProjectsResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'projects': projects != null
          ? List<dynamic>.from(projects!.map((project) => project.toJson()))
          : null,
    };
  }
}
