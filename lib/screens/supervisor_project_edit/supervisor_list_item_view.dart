import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../extensions/color_ext.dart';
import '../../reusable_components/cards/bordered_card_view.dart';
import '../../utils/typedefs.dart';

class SupervisorListItemView extends StatelessWidget {
  const SupervisorListItemView(
      {super.key,
      required this.label,
      required this.toggleValue,
      required this.callback});
  final String label;
  final bool toggleValue;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BorderedCardView(
      isSecondaryColor: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label).styled(weight: FW.bold),
            ToggleButtons(
              isSelected: [toggleValue, !toggleValue],
              onPressed: (idx) => callback(),
              selectedColor: Colors.white,
              color: Colors.black,
              fillColor: C.primary(brightness),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              borderRadius: BorderRadius.circular(8.0),
              constraints: const BoxConstraints(),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text('NO'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text('YES'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
