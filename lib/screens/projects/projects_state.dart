part of 'projects_cubit.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

final class ProjectsLoadingState extends ProjectsState {}

final class ProjectsSuccessState extends ProjectsState {}

final class ProjectsErrorState extends ProjectsState {}

final class ProjectsUpdateUIState extends ProjectsState {}

class ProjectsIndexUpdated extends ProjectsState {
  final int currentIndex;

  ProjectsIndexUpdated(this.currentIndex);
}
