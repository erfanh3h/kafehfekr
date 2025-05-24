import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ludo/Controllers/ludo_controller.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:refreshed/get_utils/get_utils.dart';

class RiskPage extends BaseView<RiskController> {
  const RiskPage({super.key});

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
          const SizedBox(height: 5),
          GlobalMultyGameDataWidget(
            playersData: controller.players.value,
            timerColor: controller.returnTimerColor(),
            activePlayerIndexes: controller.activePlayerIndexes.value,
            currentTurn: controller.currentTurn.value,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),

          // const Spacer(),
          controller.canExitGame.value && !controller.isGameFinished.value
              ? GlobalButtonWidget(
                  onTap: controller.exitGame,
                  text: AppTexts.exit.tr,
                  width: 100,
                  height: 60,
                )
              : GlobalActivityBox<LudoController>(
                  surrenderFunction: controller.surrenderByUserFunction,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
