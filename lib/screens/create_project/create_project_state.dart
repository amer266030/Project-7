part of 'create_project_cubit.dart';

@immutable
sealed class CreateProjectState {}

final class CreateProjectInitial extends CreateProjectState {}

final class UpdateUIState extends CreateProjectState {}

final class SuccessState extends CreateProjectState {
  final String msg;
  SuccessState({this.msg = 'Project Created'});
}

final class ErrorState extends CreateProjectState {
  final String msg;
  ErrorState({this.msg = 'Error Creating a Project'});
}
