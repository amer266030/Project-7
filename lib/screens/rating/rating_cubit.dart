import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../model/rating/rating.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  var commentController = TextEditingController();
  var ratingController = TextEditingController();
  var rating = Rating(
      idea: 1,
      design: 1,
      tools: 1,
      practices: 1,
      presentation: 1,
      investment: 1,
      note: '');

  RatingCubit() : super(RatingInitial());

  void updateRating(double rating, String field) {
    emit(RateState(rating));
  }

  void sendRating() {}
}
