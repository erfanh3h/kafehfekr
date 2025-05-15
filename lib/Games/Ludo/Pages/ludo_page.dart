import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ludo/Controllers/ludo_controller.dart';
import 'package:kafehfekr/Games/Ludo/Widgets/ludo_board_widget.dart';
import 'package:kafehfekr/Games/Ludo/Widgets/ludo_dice_box.dart';
import 'package:kafehfekr/Games/Mill/Controllers/mill_controller.dart';
import 'package:refreshed/get_utils/get_utils.dart';

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
          if (controller.players.length > 1)
            GlobalGameDataWidget(
              player1Data: controller.players[0].value,
              player2Data: controller.players[1].value,
              timerColor: controller.returnTimerColor(),
            ),
          const SizedBox(height: 40),
          LudoBoardWidget(controller: controller),
          const SizedBox(height: 10),
          controller.canSelectPeace.value
              ? controller.currentTurnPlayerRolled.value
                  ? LudoDiceBox(dice: controller.currentDice.value)
                  : GlobalButtonWidget(
                      onTap: controller.rollDice,
                      text: AppTexts.rollDice.tr,
                    )
              : Container(),
          const Spacer(),
          GlobalActivityBox<LudoController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
