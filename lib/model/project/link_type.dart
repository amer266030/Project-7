import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LinkType {
  github,
  figma,
  video,
  pinterest,
  playstore,
  applestore,
  apk,
  weblink,
}

extension LinkIcon on LinkType {
  IconData icon() {
    switch (this) {
      case LinkType.github:
        return FontAwesomeIcons.github;
      case LinkType.figma:
        return FontAwesomeIcons.figma;
      case LinkType.video:
        return FontAwesomeIcons.video;
      case LinkType.pinterest:
        return FontAwesomeIcons.pinterest;
      case LinkType.playstore:
        return FontAwesomeIcons.googlePlay;
      case LinkType.applestore:
        return FontAwesomeIcons.apple;
      case LinkType.apk:
        return FontAwesomeIcons.android;
      case LinkType.weblink:
        return FontAwesomeIcons.globe;
    }
  }
}
