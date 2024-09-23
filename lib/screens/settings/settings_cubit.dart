import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/managers/popup_mgr.dart';
import 'package:tuwaiq_project_pulse/screens/settings/help_support_view.dart';

import 'app_theme/app_theme_cubit.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  bool isEnglish = true;
  bool isDarkMode = true;

  void showPopup(
          {required BuildContext context,
          required String title,
          required Widget child}) =>
      PopupMgr().showPopup(context: context, title: title, child: child);

  void toggleLanguage() {
    isEnglish = !isEnglish;
    emit(UpdateUIState());
  }

  void themeButtonState(BuildContext context) {
    final currentTheme = Theme.of(context).brightness;
    isDarkMode = currentTheme == Brightness.dark ? false : true;
    emit(UpdateUIState());
  }

  void toggleDarkMode(BuildContext context) {
    isDarkMode = !isDarkMode;

    // Schedule theme change for after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeCubit = context.read<AppThemeCubit>();
      themeCubit.changeTheme(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });

    emit(UpdateUIState());
  }

  void navigateToHelpScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HelpSupportView()));
  }
}
