import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/DotBox/Controllers/dotbox_controller.dart';
import 'package:kafehfekr/Games/DotBox/Widgets/dotbox_board_widget.dart';

class DotBoxPage extends BaseView<DotBoxController> {
  const DotBoxPage({super.key});

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
            GlobalGameDataWidget(
              player1Data: controller.players[0].value,
              player2Data: controller.players[1].value,
              timerColor: controller.returnTimerColor(),
              player1Number1: controller.player1Score.value,
              player2Number1: controller.player2Score.value,
            ),
          const SizedBox(height: 55),
          DotBoxBoardWidget(controller: controller),
          const Spacer(),
          GlobalActivityBox<DotBoxController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
