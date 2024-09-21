part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class UpdateUIState extends AdminState {}

final class SuccessState extends AdminState {}

final class ErrorState extends AdminState {}
