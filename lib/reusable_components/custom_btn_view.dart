import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class CustomBtnView extends StatelessWidget {
  const CustomBtnView({
    super.key,
    required this.title,
    required this.callBack,
  });

  final String title;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BR.circular(8)),
      ),
      onPressed: () => callBack(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
          child: Text(title,
              style: const TS(color: Colors.white, fontWeight: FW.bold)),
        ),
      ),
    );
  }
}
