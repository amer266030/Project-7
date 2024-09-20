import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_popup_view.dart';

class PopupMgr {
  static final PopupMgr _instance = PopupMgr._internal();

  factory PopupMgr() {
    return _instance;
  }

  PopupMgr._internal();

  void showPopup(
      {required BuildContext context,
      required String title,
      required Widget child}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomPopupView(
            callback: Navigator.of(context).pop, title: title, child: child);
      },
    );
  }
}
