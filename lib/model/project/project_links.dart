class ProjectLinks {
  String? url;
  String? type;

  ProjectLinks({
    this.url,
    this.type,
  });

  factory ProjectLinks.fromJson(Map<String, dynamic> json) => ProjectLinks(
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
      };
}
