import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';
import 'package:tuwaiq_project_pulse/reusable_components/background_img.dart';
import 'package:tuwaiq_project_pulse/reusable_components/logo_view.dart';

import '../../extensions/color_ext.dart';
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
              body: Stack(
                children: [
                  const BackgroundImg(),
                  cubit.screens[cubit.currentIndex],
                ],
              ), // Update the body with the current screen
              bottomNavigationBar: Container(
                color: C.bg3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24), // Adjust padding if needed
                  child: Container(
                    height: context.screenHeight * 0.08, // Custom height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: C.bg1.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: BarItems.values.map((item) {
                        final index = BarItems.values
                            .indexOf(item); // Get index for each item
                        return cubit.currentIndex == index
                            ? const LogoView()
                            : IconButton(
                                icon: item
                                    .navItem()
                                    .icon, // Use icon from navItem()
                                color: cubit.currentIndex == index
                                    ? Colors.white // Highlight selected item
                                    : Colors.white, // Unselected item
                                onPressed: () => cubit.changeIndex(index),
                              );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
