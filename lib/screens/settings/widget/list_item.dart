import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';
import '../../../utils/typedefs.dart';
import '../../../reusable_components/cards/bordered_card_view.dart';

class ListItemViewForSET extends StatelessWidget {
  const ListItemViewForSET(
      {super.key,
      required this.label,
      this.isAlert = false,
      this.destination,
      required this.label2,
      required this.label3,
      required this.label4,
      required this.label5,
      required this.label6,
      this.destination2,
      this.destination3,
      this.destination4,
      this.destination5,
      this.destination6});
  final String label;
  final String label2;
  final String label3;
  final String label4;
  final String label5;
  final String label6;
  final bool isAlert;
  final Widget? destination;
  final Widget? destination2;
  final Widget? destination3;
  final Widget? destination4;
  final Widget? destination5;
  final Widget? destination6;

  void _navigate(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination!));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: BorderedCardView(
        isSecondaryColor: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap:
                    destination == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap:
                    destination2 == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label2).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap:
                    destination3 == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label3).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap:
                    destination4 == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label4).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap:
                    destination5 == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label5).styled(weight: FW.bold),
                    const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap:
                    destination6 == null ? () => () : () => _navigate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label6).styled(weight: FW.bold),
                    Image.asset('assets/setting_logo.png'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
