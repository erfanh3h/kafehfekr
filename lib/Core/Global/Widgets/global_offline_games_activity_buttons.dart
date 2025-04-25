import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/get_utils/get_utils.dart';

class OfflineActivityButtons extends StatelessWidget {
  const OfflineActivityButtons({
    super.key,
    required this.controller,
  });

  final BaseOfflineGameController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GlobalButtonWidget(
          onTap: controller.resetGame,
          text: AppTexts.restart.tr,
        ),
        GlobalButtonWidget(
          onTap: controller.exitGame,
          text: AppTexts.exit.tr,
        ),
      ],
    );
  }
}
