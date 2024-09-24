import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/list_items/list_item_view.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/settings/settings_popup_items.dart';

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
        return SafeArea(
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
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          if (state is SettingsInitial) {
                            cubit.themeButtonState(context);
                          }
                          return Column(
                            children: [
                              ListItemView(
                                label: 'Language',
                                toggleValue: cubit.isEnglish,
                                toggleType: SettingsToggleType.language,
                                callback: cubit.toggleLanguage,
                              ),
                              ListItemView(
                                label: 'Dark Mode',
                                toggleValue: cubit.isDarkMode,
                                toggleType: SettingsToggleType.darkMode,
                                callback: () => cubit.toggleDarkMode(context),
                              ),
                            ],
                          );
                        },
                      ),
                      const Text('More').styled(
                          size: 18, weight: FW.bold, color: Colors.black),
                      ...SettingsPopupItems.values.map(
                        (item) => ListItemView(
                          label: item.title,
                          callback: () => cubit.showPopup(
                            context: context,
                            title: item.title,
                            child: Text(item.description),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/bottom_settings.png'),
              ],
            ),
          ),
        );
      }),
    );
  }
}
