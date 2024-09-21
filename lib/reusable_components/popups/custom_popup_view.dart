import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class CustomPopupView extends StatelessWidget {
  const CustomPopupView({
    super.key,
    required this.title,
    required this.child,
    this.callback,
  });
  final String title;
  final Widget child;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: AspectRatio(
        aspectRatio: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(CupertinoIcons.circle, color: Colors.transparent),
                Text(title).styled(weight: FW.bold),
                InkWell(
                    onTap: callback,
                    child: const Icon(CupertinoIcons.xmark_circle_fill,
                        color: C.primary))
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
