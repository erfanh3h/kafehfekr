import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Features/General/Controllers/history_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/game_history_row_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/user_games_history_widget.dart';
import 'package:refreshed/refreshed.dart';

class HistoryPage extends BaseView<HistoryController> {
  const HistoryPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 20),
          GlobalPageHeader(label: AppTexts.history.tr),
          const SizedBox(height: 5),
          if (controller.myHistoryData.value != null)
            Column(
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
          const SizedBox(height: 25),
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            child: Text(
              AppTexts.rankHistoryDetails.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 30,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: UserGamesHistoryWidget(
              data: controller.myHistoryData.value!,
            ),
          ),
        ],
      ),
    );
  }
}
