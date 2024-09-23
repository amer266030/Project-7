part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class UpdateUIState extends AuthState {}

final class SuccessState extends AuthState {}

final class ErrorState extends AuthState {}

final class OTPState extends AuthState {}
