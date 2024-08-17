import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Feature/BattleShip/Widgets/battleship_game_button.dart';
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
        child: Obx(
          () => Directionality(
            textDirection: TextDirection.ltr,
            child: Card(
              child: Padding(
                padding: AppSpacings.s15All,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (ctx, index) => BattleShipGameButton(
                    peaceData: controller.currentTurn.value == 1
                        ? controller.player1Pieces[index].value
                        : controller.player2Pieces[index].value,
                    onTap: controller.onEachButtonTap,
                  ),
                  itemCount: controller.currentTurn.value == 1
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
