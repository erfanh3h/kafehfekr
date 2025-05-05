import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Features/General/Controllers/history_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/game_history_row_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/user_games_history_widget.dart';
import 'package:refreshed/refreshed.dart';

class HistoryPage extends BaseView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      padding: AppSpacings.s10Horizental,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.history.tr,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.lightColor,
                  ),
                ),
              ),
              backButton
            ],
          ),
          const SizedBox(height: 5),
          if (controller.myHistoryData.value != null)
            FadeIn(
              delay: const Duration(milliseconds: 250),
              child: Column(
                children: [
                  GameHistoryRowWidget(
                    data: (
                      controller.myHistoryData.value!.winRank,
                      controller.myHistoryData.value!.drawRank,
                      controller.myHistoryData.value!.loseRank,
                    ),
                    name: AppTexts.rankGame.tr,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 25),
          FadeIn(
            delay: const Duration(milliseconds: 400),
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                AppTexts.rankHistoryDetails.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 30,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          FadeIn(
            delay: const Duration(milliseconds: 400),
            child: UserGamesHistoryWidget(
              data: controller.myHistoryData.value!,
            ),
          ),
        ],
      ),
    );
  }
}
