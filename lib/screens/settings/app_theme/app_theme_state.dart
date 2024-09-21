part of 'app_theme_cubit.dart';

@immutable
sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

final class AppLightThemeState extends AppThemeState {}

final class AppDarkThemeState extends AppThemeState {}
