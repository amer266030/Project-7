import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);

  // Method to switch themes
  void changeTheme(ThemeMode mode) {
    mode = (mode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    emit(mode);
  }
}
