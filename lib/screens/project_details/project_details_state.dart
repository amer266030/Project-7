part of 'project_details_cubit.dart';

@immutable
sealed class ProjectDetailsState {}

final class ProjectDetailsInitial extends ProjectDetailsState {}

final class LoadingState extends ProjectDetailsState {}

final class ErrorState extends ProjectDetailsState {}

final class SuccessState extends ProjectDetailsState {}

final class UpdateUIState extends ProjectDetailsState {}
