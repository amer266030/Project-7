import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_alert_dialog.dart';

class AlertManager {
  static final AlertManager _instance = AlertManager._internal();
  bool _isAlertVisible = false;

  factory AlertManager() {
    return _instance;
  }

  AlertManager._internal();

  void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? callBack,
  }) {
    dismissPreviousAlert(context);

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: title, msg: message, callback: callBack);
      },
    ).then((_) {
      _isAlertVisible = false;
    });

    _isAlertVisible = true;
  }

  void dismissPreviousAlert(BuildContext context) {
    if (_isAlertVisible) {
      Navigator.of(context, rootNavigator: true).pop();
      _isAlertVisible = false;
    }
  }
}
