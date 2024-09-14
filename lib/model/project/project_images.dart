class ProjectImages {
  int? id;
  String? url;

  ProjectImages({
    this.id,
    this.url,
  });

  factory ProjectImages.fromJson(Map<String, dynamic> json) => ProjectImages(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
