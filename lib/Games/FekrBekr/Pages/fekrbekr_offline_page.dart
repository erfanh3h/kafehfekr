import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_offline_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_offline_board_widget.dart';

class FekrBekrOfflinePage extends BaseView<FekrBekrOfflineController> {
  const FekrBekrOfflinePage({super.key});

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
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            GlobalGameDataWidget(
              player1Data: controller.players[0].value,
              player2Data: controller.players[1].value,
              timerColor: controller.returnTimerColor(),
              player1Number1: -1,
              player2Number1: -1,
              roundText: controller.isGameInPlayPhase.value
                  ? "12 / ${controller.currentRound.value}"
                  : null,
            ),
          const SizedBox(height: 35),
          Expanded(
            child: FekrBekrOfflineBoardWidget(controller: controller),
          ),
          // Expanded(child: OfflineActivityButtons(controller: controller))
        ],
      ),
    );
  }
}
