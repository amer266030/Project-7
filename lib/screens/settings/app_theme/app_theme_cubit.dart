import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/model/enums/theme_state.dart';
import 'package:tuwaiq_project_pulse/utils/shared_theme.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());

  changeTheme(ThemeState themeState) {
    switch (themeState) {
      case ThemeState.initial:
        if (sharedPreferences!.getString('theme') != 'l') {
          sharedPreferences!.getString('theme') == 'l'
              ? emit(AppLightThemeState())
              : emit(AppDarkThemeState());
        }
        emit(AppThemeInitial());
        break;
      case ThemeState.light:
        sharedPreferences!.setString('theme', 'l');
        emit(AppLightThemeState());
        break;
      case ThemeState.dark:
        sharedPreferences!.setString('theme', 'd');
        emit(AppDarkThemeState());
        break;
    }
  }
}
