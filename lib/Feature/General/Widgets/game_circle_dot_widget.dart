import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class GameCircleDotWidget extends StatelessWidget {
  const GameCircleDotWidget({
    super.key,
    required this.pageController,
    required this.i,
    required this.controller,
  });

  final PageController pageController;
  final int i;
  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    Color color = controller.getGameColor(i);
    return Obx(
      () => InkWell(
        onTap: () {
          pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 600),
            curve: Curves.linear,
          );
        },
        child: Container(
          padding: controller.currentPage.value == i.toDouble()
              ? AppSpacings.s8All
              : AppSpacings.s5All,
          margin: AppSpacings.s3All,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.currentPage.value == i.toDouble()
                ? color
                : AppColors.lightColor,
            border: Border.all(
              color: controller.currentPage.value != i.toDouble()
                  ? color
                  : AppColors.lightColor,
            ),
          ),
        ),
      ),
    );
  }
}
