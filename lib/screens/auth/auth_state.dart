part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthUpdateState extends AuthState {
  final Color? flagBg1, flagPrimary;

  AuthUpdateState({this.flagBg1, this.flagPrimary});
}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {}

final class AuthErrorState extends AuthState {}

final class OTPState extends AuthState {}
