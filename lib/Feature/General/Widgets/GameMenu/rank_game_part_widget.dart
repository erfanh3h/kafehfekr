import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button2.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

import '../../../../Core/Global/Controllers/global_controller.dart';

class RankGamePartWidget extends BaseView<GameMenuController> {
  const RankGamePartWidget({super.key});

  @override
  Widget? floatingActionButton() {
    return Obx(
      () => !Get.find<GlobalController>().isQueueActive.value &&
              controller.selectedRankGames.length == 5
          ? FadeInUp(
              child: Container(
                height: 75,
                width: 75,
                margin: AppSpacings.s5Bottom,
                child: GlobalActivityButton2(
                  onTap: controller.startRankGame,
                  text: AppTexts.start.tr,
                  icon: GeneralIcons.rank,
                  fontColor: AppColors.darkColor,
                  backgroundColor: AppColors.lightColor,
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return FloatingActionButtonLocation.centerDocked;
  }

  @override
  Widget body(BuildContext context) {
    final gameTypesParts = GameTypes.values.toList();
    final int gamesLength = gameTypesParts.length - 1;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 10),
          FadeInDown(
            child: Padding(
              padding: AppSpacings.s10All,
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
                  const SizedBox(width: 15),
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
          const SizedBox(height: 15),
          Expanded(
            child: FadeIn(
              child: ListView.separated(
                itemBuilder: (ctx, index) => GetBuilder<GameMenuController>(
                  builder: (cont) => Obx(
                    () => MenuGamePartWidget(
                      game: gameTypesParts[index],
                      onTap: controller.onEachRankGameTap,
                      onOpenGuide: controller.openGameGuide,
                      isSelected: controller.selectedRankGames.value.contains(
                        gameTypesParts[index],
                      ),
                      difficulty:
                          GameTypeConvertor(gameType: GameTypes.values[index])
                              .toGameDifficallty(),
                    ),
                  ),
                ),
                separatorBuilder: (ctx, index) => const SizedBox(height: 25),
                itemCount: gamesLength,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
