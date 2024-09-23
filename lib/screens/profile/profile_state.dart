part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LoadingState extends ProfileState {}

final class UpdateUIState extends ProfileState {}

final class SuccessState extends ProfileState {
  final String msg;
  SuccessState(this.msg);
}

final class ErrorState extends ProfileState {}

final class IdCopiedState extends ProfileState {}

final class NoUrlState extends ProfileState {}
