import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
    var commintController = TextEditingController();

  RatingCubit() : super(RatingInitial());
  void updateRating(double rating) {
    emit(RateState(rating));
  }
}
