import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/list_item_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/list_item_view_settings.dart';

import '../../reusable_components/background_img.dart';
import '../../utils/typedefs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  final projectId = 'p-JGqY6xjCAK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(children: [
                    const Text('Settings').styled(size: 18, weight: FW.bold)
                  ]),
                  Expanded(
                    child: ListView(
                      children: [
                        const ListItemView(label: 'Item'),
                        const ListItemView(label: 'Item'),
                        const Text('More').styled(
                            size: 18, weight: FW.bold, color: Colors.black),
                        const ListItemViewForSET(
                          label: 'Item',
                          destination: Text('data'),
                          label2: 'Item2',
                          destination2: Text('data'),
                          label3: 'Item3',
                          destination3: Text('data'),
                          label4: 'Item4',
                          destination4: Text('data'),
                          label5: 'Item5',
                          destination5: Text('data'),
                          label6: 'Item6',
                          destination6: Text('data'),
                          label7: 'Item7',
                          destination7: Text('data'),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.rectangle_fill, color: Colors.white),
                      Icon(CupertinoIcons.circle_fill, color: Colors.white),
                      Icon(CupertinoIcons.rectangle_fill, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
