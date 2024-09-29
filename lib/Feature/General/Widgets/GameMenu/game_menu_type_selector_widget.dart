import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuTypeSelectorWidget extends StatelessWidget {
  const GameMenuTypeSelectorWidget({
    super.key,
    required this.controller,
  });

  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 150),
      child: Center(
        child: Container(
          padding: AppSpacings.s5All,
          width: 200.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedTab.value == 0
                          ? AppColors.lightColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () => controller.changeTab(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTexts.normalGame.tr,
                            style: TextStyle(
                              color: controller.selectedTab.value == 0
                                  ? AppColors.darkColor
                                  : AppColors.lightColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            GeneralIcons.normal,
                            color: controller.selectedTab.value == 0
                                ? AppColors.darkColor
                                : AppColors.lightColor,
                            width: 25,
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedTab.value == 1
                          ? AppColors.lightColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () => controller.changeTab(1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTexts.rankGame.tr,
                            style: TextStyle(
                              color: controller.selectedTab.value == 1
                                  ? AppColors.darkColor
                                  : AppColors.lightColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            GeneralIcons.rank,
                            color: controller.selectedTab.value == 1
                                ? AppColors.darkColor
                                : AppColors.lightColor,
                            width: 25,
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
