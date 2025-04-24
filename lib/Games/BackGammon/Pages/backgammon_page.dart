import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Games/BackGammon/Widgets/backgammon_board_widget.dart';
import 'package:kafehfekr/Games/BackGammon/Widgets/backgammon_dices_box.dart';

class BackGammonPage extends BaseView<BackGammonController> {
  const BackGammonPage({super.key});

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
              player1Number1: controller.player1Score.value,
              player2Number1: controller.player2Score.value,
              player1Number2: controller.player1OutPieces.value,
              player2Number2: controller.player2OutPieces.value,
              player1Number3: controller.players[0].value.notPlayedTurns,
              player2Number3: controller.players[1].value.notPlayedTurns,
            ),
          const SizedBox(height: 50),
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
