part of 'public_project_cubit.dart';

@immutable
sealed class PublicProjectState {}

final class PublicProjectInitial extends PublicProjectState {}

final class PublicProjectSuccessState extends PublicProjectState {
}
final class PublicProjectErrorState extends PublicProjectState {}

final class PublicProjectUpdateUIState extends PublicProjectState {}
