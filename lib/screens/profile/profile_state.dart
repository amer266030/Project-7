part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileUpdateState extends ProfileState {}

final class ProfileErrorState extends ProfileState {}

final class ProfileIdCopiedState extends ProfileState {}
