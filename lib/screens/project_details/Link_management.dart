import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';

import '../../model/project/link_type.dart';
import '../../model/project/project.dart';

extension LinkManagement on ProjectDetailsCubit {
  TextEditingController getControllerForLink(LinkType linkType) {
    // Fixing the method signature
    switch (linkType) {
      case LinkType.github:
        return githubController;
      case LinkType.figma:
        return figmaController;
      case LinkType.video:
        return videoController;
      case LinkType.pinterest:
        return pintresetController;
      case LinkType.playstore:
        return googleController;
      case LinkType.applestore:
        return appleController;
      case LinkType.apk:
        return androidController;
      case LinkType.weblink:
        return webController;
      default:
        return TextEditingController(); // Return a default controller if needed
    }
  }

  String getUrlForLink(LinkType linkType) {
    switch (linkType) {
      case LinkType.github:
        return githubController.text;
      case LinkType.figma:
        return figmaController.text;
      case LinkType.video:
        return videoController.text;
      case LinkType.pinterest:
        return pintresetController.text;
      case LinkType.playstore:
        return googleController.text;
      case LinkType.applestore:
        return appleController.text;
      case LinkType.apk:
        return androidController.text;
      case LinkType.weblink:
        return webController.text;
      default:
        return ''; // Return an empty string if needed
    }
  }

  void loadLinks(Project project) {
    if (project.linksProject != null) {
      final links = project.linksProject!;

      githubController.text = links
              .where((link) => link.type == LinkType.github)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      figmaController.text = links
              .where((link) => link.type == LinkType.figma)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      videoController.text = links
              .where((link) => link.type == LinkType.video)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      pintresetController.text = links
              .where((link) => link.type == LinkType.pinterest)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      googleController.text = links
              .where((link) => link.type == LinkType.playstore)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      appleController.text = links
              .where((link) => link.type == LinkType.applestore)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      appleController.text = links
              .where((link) => link.type == LinkType.apk)
              .toList()
              .firstOrNull
              ?.url ??
          '';
      webController.text = links
              .where((link) => link.type == LinkType.weblink)
              .toList()
              .firstOrNull
              ?.url ??
          '';
    }
  }
}
