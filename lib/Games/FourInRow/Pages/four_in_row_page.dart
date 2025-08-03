import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/FourInRow/Controllers/four_in_row_controller.dart';
import 'package:kafehfekr/Games/FourInRow/Widgets/four_in_row_board_widget.dart';

class FourInRowPage extends BaseView<FourInRowController> {
  const FourInRowPage({super.key});

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
          GlobalMultyGameDataWidget(
            playersData: controller.players.value,
            timerColor: controller.returnTimerColor(),
            activePlayerIndexes: const [1, 2],
            currentTurn: 0,
            usersNum1: [
              controller.player1Pawns.value,
              controller.player2Pawns.value,
            ],
          ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              FourInRowBoardWidget(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GlobalActivityBox<FourInRowController>(),
        const SizedBox(height: 20),
      ],
    );
  }
}
