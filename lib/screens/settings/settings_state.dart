part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class UpdateUIState extends SettingsState {}

final class ShowPopupState extends SettingsState {}
