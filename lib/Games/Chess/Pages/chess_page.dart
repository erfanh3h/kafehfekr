import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Chess/Controllers/chess_controller.dart';
import 'package:kafehfekr/Games/Chess/Widgets/chess_board_widget.dart';

class ChessPage extends BaseView<ChessController> {
  const ChessPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 15),
        if (controller.players.length > 1)
          GlobalGameDataWidget(
            player1Data: controller.players[0].value,
            player2Data: controller.players[1].value,
            timerColor: controller.returnTimerColor(),
            player1Number1: -1,
            player2Number1: -1,
            player1Number3: controller.players[0].value.notPlayedTurns,
            player2Number3: controller.players[1].value.notPlayedTurns,
          ),
        const SizedBox(height: 55),
        Expanded(
          child: ListView(
            children: [
              Transform.flip(
                flipY: controller.myGameId == 1,
                child: ChessBoardWidget(controller: controller),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GlobalActivityBox<ChessController>(),
        const SizedBox(height: 20),
      ],
    );
  }
}
