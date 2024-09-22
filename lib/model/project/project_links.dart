import 'link_type.dart';

class ProjectLinks {
  String? url;
  LinkType? type;

  ProjectLinks({
    this.url,
    this.type,
  });

  factory ProjectLinks.fromJson(Map<String, dynamic> json) => ProjectLinks(
        url: json["url"],
        type: _stringToLinkType(json["type"]), // Convert string to enum
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": _linkTypeToString(type), // Convert enum to string
      };

  static LinkType? _stringToLinkType(String? type) {
    switch (type) {
      case "github":
        return LinkType.github;
      case "figma":
        return LinkType.figma;
      case "video":
        return LinkType.video;
      case "pinterest":
        return LinkType.pinterest;
      case "playstore":
        return LinkType.playstore;
      case "applestore":
        return LinkType.applestore;
      case "apk":
        return LinkType.apk;
      case "weblink":
        return LinkType.weblink;
      default:
        return null; // Handle unknown types
    }
  }

  static String? _linkTypeToString(LinkType? type) {
    if (type == null) return null;
    switch (type) {
      case LinkType.github:
        return "github";
      case LinkType.figma:
        return "figma";
      case LinkType.video:
        return "video";
      case LinkType.pinterest:
        return "pinterest";
      case LinkType.playstore:
        return "playstore";
      case LinkType.applestore:
        return "applestore";
      case LinkType.apk:
        return "apk";
      case LinkType.weblink:
        return "weblink";
      default:
        return null;
    }
  }
}
