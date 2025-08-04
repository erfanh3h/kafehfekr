import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Games/BackGammon/Widgets/backgammon_board_widget.dart';
import 'package:kafehfekr/Games/BackGammon/Widgets/backgammon_dices_box.dart';

class BackGammonPage extends BaseView<BackGammonController> {
  const BackGammonPage({super.key});

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
              usersNum1: [
                controller.player1Score.value,
                controller.player2Score.value,
              ],
              usersNum2: [
                controller.player1OutPieces.value,
                controller.player2OutPieces.value,
              ],
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                if (controller.peaces.length > 12)
                  BackGammonBoardWidget(controller: controller),
                const SizedBox(height: 15),
                BackGammonDicesBox(controller: controller),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<BackGammonController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
