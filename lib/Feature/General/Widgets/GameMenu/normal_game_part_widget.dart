import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/game_circle_dot_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/GameMenu/normal_menu_game_part_widget.dart';
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
    final int gamesLength = marketType == MarketTypes.Bazaar
        ? gameTypesParts.length - 1
        : gameTypesParts.length;

    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: PageView.builder(
            controller: controller.normalPageController,
            onPageChanged: controller.changeNormalPage,
            itemBuilder: (ctx, index) => Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.normalPageController.animateToPage(
                      index != 0 ? index - 1 : (gamesLength - 1),
                      duration: Duration(milliseconds: index != 0 ? 300 : 1000),
                      curve: Curves.linear,
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_right_square,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
                Expanded(
                  child: Obx(
                    () => NormalGameMenuGamePartWidget(
                      game: gameTypesParts[index],
                      onTap: controller.startNormalGame,
                      onGuideTap: controller.openGameGuide,
                      showButtons:
                          !Get.find<GlobalController>().isQueueActive.value,
                      difficultyColor: controller.getGameColor(index),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.normalPageController.animateToPage(
                      index != (gamesLength - 1) ? index + 1 : 0,
                      duration: Duration(
                          milliseconds:
                              index != (gamesLength - 1) ? 300 : 1000),
                      curve: Curves.linear,
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_left_square,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
            itemCount: gamesLength,
          ),
        ),
        Padding(
          padding: AppSpacings.s20Horizental5Vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < gamesLength; i++)
                GameCircleDotWidget(
                  pageController: controller.normalPageController,
                  i: i,
                  controller: controller,
                )
            ],
          ),
        ),
        // Padding(
        //   padding: AppSpacings.s20Horizental,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       for (int i = 10; i < gamesLength; i++)
        //         GameCircleDotWidget(
        //           pageController: controller.normalPageController,
        //           i: i,
        //           controller: controller,
        //         )
        //     ],
        //   ),
        // ),
        const SizedBox(height: 10),
      ],
    );
  }
}
