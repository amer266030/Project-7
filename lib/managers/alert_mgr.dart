import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_alert_dialog.dart';

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
    required bool withDismiss,
  }) {
    dismissPreviousAlert(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: title, msg: message, callback: () => dismiss(context));
      },
    ).then((_) {
      _isAlertVisible = false;
    });

    _isAlertVisible = true;
  }

  void dismiss(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    _isAlertVisible = false;
  }

  void dismissPreviousAlert(BuildContext context) {
    if (_isAlertVisible) {
      dismiss(context);
    }
  }
}
