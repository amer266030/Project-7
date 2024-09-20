import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.msg,
    required this.callback,
  });
  final String title;
  final String msg;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title.isNotEmpty
          ? Text(title)
          : const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: AspectRatio(
                  aspectRatio: 1, child: CircularProgressIndicator()),
            ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(msg),
      ),
      actions: <Widget>[
        if (title.isNotEmpty)
          ElevatedBtnView(
            title: 'OK',
            callBack: () => callback!(),
          )
      ],
    );
  }
}
