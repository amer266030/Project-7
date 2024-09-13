import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_items.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int currentIndex = 0;
  final List<Widget> screens =
      BarItems.values.map((item) => item.screen()).toList();

  void changeIndex(int idx) {
    currentIndex = idx;
    emit(BottomNavUpdateState());
  }
}
