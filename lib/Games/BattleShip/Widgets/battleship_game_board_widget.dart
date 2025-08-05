import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_game_button.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipGameBoardWidget extends StatelessWidget {
  const BattleShipGameBoardWidget({
    super.key,
    required this.controller,
  });

  final BattleShipController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s5All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: GlobalFrameWrapper(
            frame: AppImages.board,
            child: Padding(
              padding: AppSpacings.s15All,
              child: Obx(
                () => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (ctx, index) => Obx(
                    () => BattleShipGameButton(
                      peaceData: controller.currentTurn.value == 2
                          ? controller.player1Pieces[index].value
                          : controller.player2Pieces[index].value,
                      onTap: controller.onEachButtonTap,
                      baseColor: controller.currentTurn.value == 1
                          ? AppColors.imageRedColor
                          : AppColors.imageBlueColor,
                    ),
                  ),
                  itemCount: controller.currentTurn.value == 2
                      ? controller.player1Pieces.length
                      : controller.player2Pieces.length,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
