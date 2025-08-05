import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/BattleShip/Controllers/battleship_controller.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_game_board_widget.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_selection_board_widget.dart';
import 'package:kafehfekr/Games/BattleShip/Widgets/battleship_ship_selection_box.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipPage extends BaseView<BattleShipController> {
  const BattleShipPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            GlobalMultyGameDataWidget(
              playersData: controller.players.value,
              timerColor: controller.returnTimerColor(),
              activePlayerIndexes: const [1, 2],
              currentTurn: controller.currentTurn.value,
              usersNum1: controller.isGameInPlayPhase.value
                  ? [
                      controller.player1Score.value,
                      controller.player2Score.value,
                    ]
                  : null,
            ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              children: [
                !controller.isGameStarted.value
                    ? const Center(child: GlobalWaitWidget())
                    : controller.isGameInPlayPhase.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                return GlobalFrameWrapper(
                                  frame: AppImages.board,
                                  padding: AppSpacings.s10All,
                                  child: Text(
                                    "  زمین ${controller.getInActiveGamerUsername()} ",
                                    style: const TextStyle(
                                      color: AppColors.lightColor,
                                      fontSize: 20,
                                    ),
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
