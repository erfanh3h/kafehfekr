import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class NormalGamePartWidget extends StatelessWidget {
  const NormalGamePartWidget({
    super.key,
    required this.controller,
  });

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
                      AppTexts.normalGameMenu.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => Text(
                      "${controller.selectedNormalGames.length}/2",
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
                    () => MenuGamePartWidget(
                      game: gameTypesParts[index],
                      onTap: controller.onEachNormalGameTap,
                      onOpenGuide: controller.openGameGuide,
                      isSelected: controller.selectedNormalGames.value.contains(
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
                    child: GlobalButtonWidget(
                      onTap: controller.startNormalGame,
                      text: AppTexts.startGame.tr,
                      color: const Color.fromARGB(255, 12, 63, 32),
                      fontColor: AppColors.lightColor,
                      width: double.maxFinite,
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
