part of 'public_cubit.dart';

@immutable
sealed class PublicState {}

final class PublicInitial extends PublicState {}

final class PublicLoadingState extends PublicState {}

final class PublicSuccessState extends PublicState {}

final class PublicErrorState extends PublicState {}

final class PublicUpdateUIState extends PublicState {}
