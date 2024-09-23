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
      this.toggleType,
      this.callback});
  final String label;
  final bool? toggleValue;
  final ToggleType? toggleType;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => (toggleValue != null || callback == null) ? () : callback!(),
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
                      isSelected: [toggleValue!, !toggleValue!],
                      onPressed: (idx) => callback == null ? () : callback!(),
                      selectedColor: Colors.white,
                      color: Colors.black,
                      fillColor: C.primary(context),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      borderRadius: BorderRadius.circular(8.0),
                      constraints: const BoxConstraints(),
                      children: toggleType!.widgetArr.map((v) => v).toList(),
                    )
                  : Icon(CupertinoIcons.arrow_right_circle_fill,
                      color: C.primary(context))
            ],
          ),
        ),
      ),
    );
  }
}

enum ToggleType { language, darkMode }

extension ToggleValues on ToggleType {
  List<Widget> get widgetArr {
    switch (this) {
      case ToggleType.language:
        return [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text('AR'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text('EN'),
          )
        ];
      case ToggleType.darkMode:
        return [
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Icon(CupertinoIcons.sun_max, size: 20)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Icon(CupertinoIcons.moon, size: 20),
          )
        ];
    }
  }
}
