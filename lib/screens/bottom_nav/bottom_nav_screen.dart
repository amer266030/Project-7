import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_cubit.dart';
import 'bottom_nav_items.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<BottomNavCubit>();
        return BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                enableFeedback: false,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: cubit.currentIndex,
                onTap: (idx) => cubit.changeIndex(idx),
                items: BarItems.values.map((item) => item.navItem()).toList(),
              ),
            );
          },
        );
      }),
    );
  }
}
