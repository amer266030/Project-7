import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/list_item_view.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_cubit.dart';

import '../../reusable_components/images/background_img.dart';
import '../../utils/typedefs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final projectId = 'p-JGqY6xjCAK';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<SettingsCubit>();
        return Scaffold(
          body: Stack(
            children: [
              const BackgroundImg(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Row(children: [
                        const Text('Settings').styled(size: 18, weight: FW.bold)
                      ]),
                      Expanded(
                        child: ListView(
                          children: [
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    ListItemView(
                                      label: 'Language',
                                      toggleValue: cubit.isEnglish,
                                    ),
                                    ListItemView(
                                        label: 'Dark Mode',
                                        toggleValue: cubit.isDarkMode),
                                  ],
                                );
                              },
                            ),
                            const Text('More').styled(
                                size: 18, weight: FW.bold, color: Colors.black),
                            const ListItemView(
                                label: 'About Us', isPopup: true),
                            const ListItemView(label: 'Help & Support'),
                            const ListItemView(
                                label: 'Terms and Conditions', isPopup: true),
                            const ListItemView(
                                label: 'Privacy Policy', isPopup: true),
                          ],
                        ),
                      ),
                      Image.asset('assets/bottom_settings.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
