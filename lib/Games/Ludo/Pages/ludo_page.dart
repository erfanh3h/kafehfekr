import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Ludo/Controllers/ludo_controller.dart';
import 'package:kafehfekr/Games/Ludo/Widgets/ludo_board_widget.dart';

class LudoPage extends BaseView<LudoController> {
  const LudoPage({super.key});

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
          // if (controller.players.length > 1)
          //   GlobalGameDataWidget(
          //     player1Data: controller.players[0].value,
          //     player2Data: controller.players[1].value,
          //     timerColor: controller.returnTimerColor(),
          //     player1Number1: controller.player2RemovedPeaces.value,
          //     player2Number1: controller.player1RemovedPeaces.value,
          //     player1Number2: controller.player1Peaces.value -
          //         controller.player1PlayedPeaces.value,
          //     player2Number2: controller.player2Peaces.value -
          //         controller.player2PlayedPeaces.value,
          //     player1Number3: controller.players[0].value.notPlayedTurns,
          //     player2Number3: controller.players[1].value.notPlayedTurns,
          //   ),
          const SizedBox(height: 55),
          LudoBoardWidget(controller: controller),
          const Spacer(),
          // GlobalActivityBox<MillController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
