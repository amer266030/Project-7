part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}
final class RateState extends RatingState {
  final double rating;
  RateState(this.rating);
}
