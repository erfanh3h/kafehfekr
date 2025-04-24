import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Widgets/tictactoe_board_widget.dart';

class TicTacToePage extends BaseView<TicTacToeController> {
  const TicTacToePage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
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
              roundText: "${controller.maxRound} / ${controller.currentRound}",
            ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                TicTacToeBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<TicTacToeController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
