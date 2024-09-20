import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../extensions/color_ext.dart';
import '../utils/typedefs.dart';
import 'cards/bordered_card_view.dart';

class ListItemView extends StatelessWidget {
  const ListItemView(
      {super.key,
      required this.label,
      this.toggleValue,
      this.isPopup = false,
      this.callback});
  final String label;
  final bool? toggleValue;
  final bool isPopup;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: callback,
        child: BorderedCardView(
          isSecondaryColor: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label).styled(weight: FW.bold),
                (toggleValue != null)
                    ? ToggleButtons(
                        isSelected: [
                            toggleValue! ? toggleValue! : !toggleValue!,
                            toggleValue! ? toggleValue! : !toggleValue!
                          ],
                        children:
                            ToggleType.values.map((v) => Text(v.name)).toList())
                    : const Icon(CupertinoIcons.arrow_right_circle_fill,
                        color: C.primary)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ToggleType { language, darkMode }

extension ToggleValues on ToggleType {
  List<Widget> widgetArr() {
    switch (this) {
      case ToggleType.language:
        return [const Text('AR'), const Text('EN')];
      case ToggleType.darkMode:
        return [
          const Icon(CupertinoIcons.sun_max),
          const Icon(CupertinoIcons.moon)
        ];
    }
  }
}
