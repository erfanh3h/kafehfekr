import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_result_row_widget.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_selection_row_box.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrEnemyChoicesBox extends StatelessWidget {
  const FekrBekrEnemyChoicesBox({
    super.key,
    required this.controller,
  });

  final FekrBekrController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s20All,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < controller.myBoard.length; i++)
                          FekrBekrSelectionRowBox(
                            value: controller.myBoard[i],
                          ),
                      ],
                    ),
                  ),
                  Text(
                    AppTexts.yourBoard.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: AppColors.lightColor, height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final int reversedIndex = (controller.myGameId == 1
                        ? controller.player1Results.length
                        : controller.player2Results.length) -
                    index -
                    1;
                return FekrBekrResultRowWidget(
                  selectionData: controller.myGameId == 1
                      ? controller.player2Choices[reversedIndex]
                      : controller.player1Choices[reversedIndex],
                  resultData: controller.myGameId == 1
                      ? controller.player2Results[reversedIndex]
                      : controller.player1Results[reversedIndex],
                  index: reversedIndex,
                );
              },
              itemCount: controller.myGameId == 1
                  ? controller.player2Results.length
                  : controller.player1Results.length,
            ),
          ),
        ],
      ),
    );
  }
}
