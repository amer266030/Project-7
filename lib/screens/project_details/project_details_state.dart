part of 'project_details_cubit.dart';

@immutable
sealed class ProjectDetailsState {}

final class ProjectDetailsInitial extends ProjectDetailsState {}

final class LoadingState extends ProjectDetailsState {}

final class ErrorState extends ProjectDetailsState {
  final String msg;
  ErrorState(this.msg);
}

final class SuccessState extends ProjectDetailsState {
  final String msg;
  SuccessState(this.msg);
}

final class UpdateUIState extends ProjectDetailsState {}

final class ProjectDeletedState extends ProjectDetailsState {}

final class NoUrlState extends ProjectDetailsState {}
