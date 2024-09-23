import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../extensions/color_ext.dart';
import '../../reusable_components/images/background_img.dart';
import 'bottom_nav_cubit.dart';
import 'bottom_nav_items.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final barItems = BarItems(context);
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<BottomNavCubit>();
        return BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: C.bg1(context),
              body: Stack(
                children: [
                  const BackgroundImg(),
                  Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: cubit.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            barItems.bottomBarItems.length,
                            (index) => barItems.bottomBarPages[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              extendBody: true,
              bottomNavigationBar: (barItems.bottomBarPages.length <=
                      barItems.bottomBarItems.length)
                  ? AnimatedNotchBottomBar(
                      notchBottomBarController: cubit.notchController,
                      color: C.navBar(context),
                      showLabel: true,
                      textOverflow: TextOverflow.visible,
                      maxLine: 1,
                      shadowElevation: 5,
                      kBottomRadius: 28.0,
                      notchGradient: LinearGradient(
                          colors: [C.bg1(context), C.bg2(context)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      removeMargins: false,
                      showShadow: false,
                      durationInMilliSeconds: 150,
                      elevation: 1,
                      bottomBarItems: barItems.bottomBarItems,
                      onTap: (index) {
                        cubit.pageController.jumpToPage(index);
                      },
                      kIconSize: 24.0,
                    )
                  : null,
            );
          },
        );
      }),
    );
  }
}
