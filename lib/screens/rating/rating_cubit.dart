import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tuwaiq_project_pulse/model/rating/rating_field.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../model/rating/rating.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  var userApi = NetworkingApi.shared.userApi;
  var commentController = TextEditingController();

  var newRating = Rating(
      idea: 1,
      design: 1,
      tools: 1,
      practices: 1,
      presentation: 1,
      investment: 1,
      note: '');

  RatingCubit() : super(RatingInitial());

  void updateRating(double rating, RatingField field) {
    switch (field) {
      case RatingField.idea:
        newRating.idea = rating.toInt();
      case RatingField.design:
        newRating.idea = rating.toInt();
      case RatingField.tools:
        newRating.idea = rating.toInt();
      case RatingField.practices:
        newRating.idea = rating.toInt();
      case RatingField.presentation:
        newRating.idea = rating.toInt();
      case RatingField.investment:
        newRating.idea = rating.toInt();
    }
    emit(RateState(rating));
  }

  Future<void> sendRating(String projectId) async {
    newRating.note = commentController.text;
    try {
      await userApi.createRating(projectId: projectId, rating: newRating);
    } catch (e) {
      print('$e');
    }
  }
}
