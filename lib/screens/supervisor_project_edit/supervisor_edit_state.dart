part of 'supervisor_edit_cubit.dart';

@immutable
sealed class SupervisorEditState {}

final class SupervisorEditInitial extends SupervisorEditState {}

final class UpdateUIState extends SupervisorEditState {}

final class SuccessState extends SupervisorEditState {}

final class ErrorState extends SupervisorEditState {}
