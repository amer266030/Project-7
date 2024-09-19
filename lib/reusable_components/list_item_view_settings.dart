import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../extensions/color_ext.dart';
import '../utils/typedefs.dart';
import 'cards/bordered_card_view.dart';

class ListItemViewForSET extends StatelessWidget {
  const ListItemViewForSET(
      {super.key, required this.label, this.isAlert = false, this.destination, required this.label2, required this.label3, required this.label4, required this.label5, required this.label6, required this.label7});
  final String label;
  final String label2;
  final String label3;
  final String label4;
  final String label5;
  final String label6;
  final String label7;
  final bool isAlert;
  final Widget? destination;

  void _navigate(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination!));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: destination == null ? () => () : () => _navigate(context),
        child: BorderedCardView(
          isSecondaryColor: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label2).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label3).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label4).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label5).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label6).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label7).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
