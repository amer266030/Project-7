import 'package:flutter/material.dart';
import '../../extensions/color_ext.dart';
import '../../utils/typedefs.dart';

class ElevatedBtnView extends StatelessWidget {
  const ElevatedBtnView({
    super.key,
    required this.title,
    this.icon,
    this.hasBorder = false,
    required this.callBack,
  });

  final String title;
  final IconData? icon;
  final bool hasBorder;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shadowColor: C.primary(context),
        backgroundColor: C.primary(context),
        shape: RoundedRectangleBorder(
            borderRadius: BR.circular(8),
            side: BorderSide(
                color: hasBorder ? C.bg1(context) : Colors.transparent,
                width: 2)),
      ),
      onPressed: () => callBack(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TS(color: Colors.white, fontWeight: FW.bold)),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(icon, color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
