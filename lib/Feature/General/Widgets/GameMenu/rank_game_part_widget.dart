import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_gold_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/rank_menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

import '../../../../Core/Global/Controllers/global_controller.dart';

class RankGamePartWidget extends StatelessWidget {
  const RankGamePartWidget({super.key, required this.controller});

  final GameMenuController controller;

  @override
  Widget build(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = gameTypesParts.length - 1;

    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          FadeInDown(
            child: Padding(
              padding: AppSpacings.s20All,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppTexts.rankGameMenu.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => Text(
                      "${controller.selectedRankGames.length}/5",
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 20,
                        fontFamily: FontFamilies.playPen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FadeIn(
              child: ListView.separated(
                itemBuilder: (ctx, index) => GetBuilder<GameMenuController>(
                  builder: (cont) => Obx(
                    () => RankMenuGamePartWidget(
                      game: gameTypesParts[index],
                      onTap: controller.onEachRankGameTap,
                      onOpenGuide: controller.openGameGuide,
                      isSelected: controller.selectedRankGames.value.contains(
                        gameTypesParts[index],
                      ),
                      difficultyColor: controller.getGameColor(index),
                    ),
                  ),
                ),
                separatorBuilder: (ctx, index) => const SizedBox(height: 5),
                itemCount: gamesLength,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Obx(
            () => !Get.find<GlobalController>().isQueueActive.value
                ? FadeInUp(
                    child: SizedBox(
                      height: 40.h,
                      width: double.maxFinite,
                      // padding: AppSpacings.s20Horizental,
                      child: GlobalGoldButtonWidget(
                        onTap: controller.startRankGame,
                        goldCount: 15,
                        text: AppTexts.startGame.tr,
                        color: const Color.fromARGB(255, 12, 63, 32),
                        fontColor: AppColors.lightColor,
                        height: 40.h,
                      ),
                    ),
                  )
                : Container(),
          ),
          // const SizedBox(height: 5),
        ],
      ),
    );
  }
}
