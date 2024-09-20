import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/settings/widget/list_item.dart';
import 'package:tuwaiq_project_pulse/screens/settings/widget/list_item_utils.dart';

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
                        const ListItem(label: 'Language'),
                        const ListItem(label: 'Dark Mode'),
                        const Text('More').styled(
                            size: 18, weight: FW.bold, color: Colors.black),
                        const ListItemViewForSET(
                          label: 'About Us',
                          destination: null,
                          label2: 'About App',
                          destination2: null,
                          label3: 'Help & Support',
                          destination3: null,
                          label4: 'Terms and Conditions',
                          destination4: null,
                          label5: 'Privacy',
                          destination5: null,
                          label6: 'Policy',
                          destination6: null,
                        ),
                        const SizedBox(height: 50),
                        Image.asset('assets/bottom_settings.png'),
                      ],
                    ),
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
