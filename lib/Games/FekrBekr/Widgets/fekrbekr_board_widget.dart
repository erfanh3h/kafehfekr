import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_button.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_enemy_choices_box.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_result_row_widget.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_select_numbers_box.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrBoardWidget extends StatelessWidget {
  const FekrBekrBoardWidget({
    super.key,
    required this.controller,
  });

  final FekrBekrController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Container(
          padding: AppSpacings.s15All,
          height:
              (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) + 100,
          width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isGameInPlayPhase.value
                  ? Expanded(
                      child: GetBuilder<FekrBekrController>(
                        builder: (context) {
                          return GlobalFrameWrapper(
                            padding: AppSpacings.s20All,
                            frame: AppImages.board,
                            child: Obx(
                              () => ListView.builder(
                                controller: controller.historyController,
                                itemBuilder: (ctx, index) {
                                  final int reversedIndex =
                                      (controller.myGameId == 1
                                              ? controller.player1Results.length
                                              : controller
                                                  .player2Results.length) -
                                          index -
                                          1;

                                  return FekrBekrResultRowWidget(
                                    selectionData: controller.myGameId == 1
                                        ? controller
                                            .player1Choices[reversedIndex]
                                        : controller
                                            .player2Choices[reversedIndex],
                                    resultData: controller.myGameId == 1
                                        ? controller
                                            .player1Results[reversedIndex]
                                        : controller
                                            .player2Results[reversedIndex],
                                    index: reversedIndex,
                                  );
                                },
                                itemCount: controller.myGameId == 1
                                    ? controller.player1Results.length
                                    : controller.player2Results.length,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : GlobalFrameWrapper(
                      frame: AppImages.frame4,
                      child: Text(
                        AppTexts.selectBoard.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontSize: 22,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GlobalFrameWrapper(
                      frame: AppImages.board,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 4; i++)
                              Obx(
                                () => FekrBekrButton(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: FekrBekrSelectNumbersBox(
                              controller: controller,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              controller.isWaiting.value
                                  ? const Padding(
                                      padding: AppSpacings.s10Vertical,
                                      child: GlobalWaitWidget(),
                                    )
                                  : GlobalButtonWidget(
                                      onTap: () => controller.sendResult(
                                        controller.isGameInPlayPhase.value
                                            ? GameCommands.selectPeace
                                            : GameCommands.saveBoard,
                                      ),
                                      text: AppTexts.accept.tr,
                                    ),
                              const SizedBox(height: 3),
                              controller.isGameInPlayPhase.value
                                  ? GlobalButtonWidget(
                                      fontSize: 13,
                                      onTap: () {
                                        Get.bottomSheet(
                                          FekrBekrEnemyChoicesBox(
                                            controller: controller,
                                          ),
                                          backgroundColor: AppColors.darkColor,
                                        );
                                      },
                                      text: AppTexts.enemyChoices.tr,
                                    )
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const Divider(color: AppColors.lightColor, height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
