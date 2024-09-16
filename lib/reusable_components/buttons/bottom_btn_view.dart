import 'package:flutter/material.dart';
import '../../utils/typedefs.dart';

class BottomBtnView extends StatelessWidget {
  const BottomBtnView({
    super.key,
    required this.title,
    required this.btnColor,
    required this.textColor,
    required this.callBack,
  });

  final String title;
  final Color btnColor;
  final Color textColor;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(borderRadius: BR.circular(0)),
      ),
      onPressed: () => callBack(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Text(title,
            style: TS(color: textColor, fontWeight: FW.bold, fontSize: 20)),
      ),
    );
  }
}
