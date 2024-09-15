part of 'user_projects_cubit.dart';

@immutable
sealed class UserProjectsState {}

final class UserProjectsInitial extends UserProjectsState {}

final class UpdateUIState extends UserProjectsState {}
