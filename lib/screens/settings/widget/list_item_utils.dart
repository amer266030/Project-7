import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';
import '../../../utils/typedefs.dart';
import '../../../reusable_components/cards/bordered_card_view.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key, required this.label, this.isAlert = false, this.destination});
  final String label;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label).styled(context: context, weight: FW.bold),
                const Switch(value: true, onChanged: null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
