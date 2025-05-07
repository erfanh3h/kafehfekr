import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:kafehfekr/Games/Mafia/Widgets/mafia_game_widget.dart';
import 'package:kafehfekr/Games/Mafia/Widgets/mafia_pre_game_widget.dart';
import 'package:refreshed/utils.dart';

class MafiaOfflinePage extends BaseView<MafiaOfflineController> {
  const MafiaOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: AppSpacings.s5All,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Expanded(
            flex: 14,
            child: controller.isGamePhase.value
                ? MafiaGameWidget(controller: controller)
                : MafiaPreGameWidget(controller: controller),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GlobalButtonWidget(
                onTap: controller.isGamePhase.value
                    ? controller.resetGame
                    : controller.startGame,
                text: controller.isGamePhase.value
                    ? AppTexts.restart.tr
                    : AppTexts.startGame.tr,
              ),
              GlobalButtonWidget(
                onTap: controller.exitGame,
                text: AppTexts.exit.tr,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
