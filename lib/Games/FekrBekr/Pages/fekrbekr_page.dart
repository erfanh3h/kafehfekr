import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_board_widget.dart';

class FekrBekrPage extends BaseView<FekrBekrController> {
  const FekrBekrPage({super.key});

  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            GlobalMultyGameDataWidget(
              playersData: controller.players.value,
              timerColor: controller.returnTimerColor(),
              activePlayerIndexes: const [1, 2],
              currentTurn: controller.currentTurn.value,
              usersNum1: [
                controller.player1Score.value,
                controller.player2Score.value,
              ],
              roundText: controller.isGameInPlayPhase.value
                  ? "12 / ${controller.currentRound.value}"
                  : null,
            ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView(
              children: [
                FekrBekrBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<FekrBekrController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
