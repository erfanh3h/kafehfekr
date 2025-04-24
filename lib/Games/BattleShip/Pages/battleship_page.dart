import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_game_board_widget.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_selection_board_widget.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_ship_selection_box.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipPage extends BaseView<BattleShipController> {
  const BattleShipPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            GlobalGameDataWidget(
              player1Data: controller.players[0].value,
              player2Data: controller.players[1].value,
              timerColor: controller.returnTimerColor(),
              player1Number1: controller.isGameInPlayPhase.value
                  ? controller.player1Score.value
                  : -1,
              player2Number1: controller.isGameInPlayPhase.value
                  ? controller.player2Score.value
                  : -1,
            ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              children: [
                !controller.isGameStarted.value
                    ? const Center(child: GlobalWaitWidget())
                    : controller.isGameInPlayPhase.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Builder(builder: (context) {
                                return Text(
                                  "     صفحه ${controller.getInActiveGamerUsername()} : ",
                                  style: const TextStyle(
                                    color: AppColors.lightColor,
                                    fontSize: 20,
                                  ),
                                );
                              }),
                              const SizedBox(height: 4),
                              BattleShipGameBoardWidget(controller: controller),
                            ],
                          )
                        : controller.isWaiting.value
                            ? const Center(child: GlobalWaitWidget())
                            : Column(
                                children: [
                                  BattleShipSelectionBoardWidget(
                                      controller: controller),
                                  const SizedBox(height: 10),
                                  BattleShipShipSelectionBox(
                                      controller: controller),
                                  GlobalButtonWidget(
                                    onTap: controller.submitBoard,
                                    text: AppTexts.accept.tr,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<BattleShipController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
