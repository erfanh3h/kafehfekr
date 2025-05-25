import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_board_widget.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_game_data_widget.dart';
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
          RiskGameDataWidget(
            playersData: controller.players.value,
            riskUsersData: controller.riskUsersData,
            timerColor: controller.returnTimerColor(),
            activePlayerIndexes: controller.activePlayerIndexes.value,
            currentTurn: controller.currentTurn.value,
          ),
          Expanded(
            child: Center(
              child: RiskBoardWidget(gameState: controller.gameState.value),
            ),
          ),
          Row(
            spacing: 5,
            children: [
              Expanded(
                flex: 3,
                child: GlobalButtonWidget(
                  onTap: controller.openMyContinents,
                  text: AppTexts.myContinents.tr,
                  height: 60,
                ),
              ),
              Expanded(
                flex: 4,
                child: GlobalButtonWidget(
                  onTap: controller.openMyStrategies,
                  text: AppTexts.myStrategies.tr,
                  height: 60,
                ),
              ),
              Expanded(
                flex: 3,
                child: GlobalButtonWidget(
                  onTap: controller.openMyTokens,
                  text: AppTexts.myTokens.tr,
                  height: 60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          controller.canExitGame.value && !controller.isGameFinished.value
              ? GlobalButtonWidget(
                  onTap: controller.exitGame,
                  text: AppTexts.exit.tr,
                  width: 100,
                  height: 60,
                )
              : GlobalActivityBox<RiskController>(
                  surrenderFunction: controller.surrenderByUserFunction,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
