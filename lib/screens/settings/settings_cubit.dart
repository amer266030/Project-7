import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/managers/popup_mgr.dart';
import 'package:tuwaiq_project_pulse/screens/settings/help_support_view.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  bool isEnglish = true;
  bool isDarkMode = true;

  void showPopup(BuildContext context, String title, Widget child) =>
      PopupMgr().showPopup(context: context, title: title, child: child);

  void toggleLanguage() {
    isEnglish = !isEnglish;
    emit(UpdateSettingsUIState());
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    emit(UpdateSettingsUIState());
  }

  void navigateToHelpScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HelpSupportView()));
  }
}
