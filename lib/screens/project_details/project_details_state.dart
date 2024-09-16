part of 'project_details_cubit.dart';

@immutable
sealed class ProjectDetailsState {}

final class ProjectDetailsInitial extends ProjectDetailsState {}

final class ProjDetailsLoadingState extends ProjectDetailsState {}

final class ProjDetailsErrorState extends ProjectDetailsState {}

final class ProjDetailsSuccessState extends ProjectDetailsState {}

final class UpdateUIState extends ProjectDetailsState {}
