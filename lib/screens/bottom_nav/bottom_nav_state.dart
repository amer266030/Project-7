part of 'bottom_nav_cubit.dart';

@immutable
sealed class BottomNavState {}

final class BottomNavInitial extends BottomNavState {}

final class BottomNavUpdateState extends BottomNavState {}
