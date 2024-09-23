import 'package:flutter/material.dart';

import '../../extensions/color_ext.dart';
import '../../utils/typedefs.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.title,
    this.fontSize = 12,
    required this.callback,
  });
  final String title;
  final double fontSize;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return TextButton(
      onPressed: callback,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero), // Adjust if needed
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrinks the tap area
      ),
      child: Text(title,
          style: TS(color: C.primary(brightness), fontWeight: FontWeight.w700)),
    );
  }
}
