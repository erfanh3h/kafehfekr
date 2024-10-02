import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Checkers/Controllers/checkers_controller.dart';
import 'package:kafehfekr/Feature/Checkers/Widgets/checkers_board_widget.dart';

class CheckersPage extends BaseView<CheckersController> {
  const CheckersPage({super.key});

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
              player1Number1: controller.player1Pawns.value,
              player2Number1: controller.player2Pawns.value,
              player1Number3: controller.players[0].value.notPlayedTurns,
              player2Number3: controller.players[1].value.notPlayedTurns,
            ),
          const SizedBox(height: 55),
          Expanded(
            child: ListView(
              children: [
                Transform.flip(
                  flipY: controller.myGameId == 1,
                  child: CheckersBoarWidget(controller: controller),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<CheckersController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
