import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Chess/Controllers/chess_controller.dart';
import 'package:kafehfekr/Feature/Chess/Widgets/chess_board_widget.dart';

class ChessPage extends BaseView<ChessController> {
  const ChessPage({super.key});

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
              player1Number1: -1,
              player2Number1: -1,
            ),
          const Spacer(flex: 3),
          ChessBoardWidget(controller: controller),
          const Spacer(flex: 4),
          GlobalActivityBox<ChessController>(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
