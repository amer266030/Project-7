enum ProjectType {
  app,
  website,
  vr,
  ar,
  ai,
  ml,
  uiUx,
  gaming,
  unity,
  cyber,
  software,
  automation,
  robotic,
  api,
  analytics,
  iot,
  cloud
}

ProjectType projectTypeFromString(String type) {
  return ProjectType.values
      .firstWhere((e) => e.toString().split('.').last == type);
}

String projectTypeToString(ProjectType type) {
  return type.toString().split('.').last;
}
