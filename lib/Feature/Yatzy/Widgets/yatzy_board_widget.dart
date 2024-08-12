import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class YatzyBoardWidget extends StatelessWidget {
  YatzyBoardWidget({
    super.key,
    required this.controller,
  });

  final YatzyController controller;

  final List<String> headerImages = [
    GeneralIcons.dice1,
    GeneralIcons.dice2,
    GeneralIcons.dice3,
    GeneralIcons.dice4,
    GeneralIcons.dice5,
    GeneralIcons.dice6,
    GeneralIcons.yatzy3,
    GeneralIcons.yatzy4,
    GeneralIcons.yatzyq,
    GeneralIcons.yatzy23,
    GeneralIcons.yatzy15,
    GeneralIcons.yatzy5,
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s5All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Card(
          child: Padding(
            padding: AppSpacings.s5All,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (int index = 0; index < 6; index++)
                        Expanded(
                          child: Obx(
                            () => YatzyRowWidget(
                              headerImage: headerImages[index],
                              player1Piece:
                                  controller.player1Pieces.value[index].value,
                              player2Piece:
                                  controller.player2Pieces.value[index].value,
                              index: index,
                              myGameId: controller.myGameId,
                              onEachButtonTap: controller.onEachButtonTap,
                              onRowTap: controller.onEachRowTap,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      for (int index = 6; index < 12; index++)
                        Expanded(
                          child: Obx(
                            () => YatzyRowWidget(
                              headerImage: headerImages[index],
                              player1Piece:
                                  controller.player1Pieces.value[index].value,
                              player2Piece:
                                  controller.player2Pieces.value[index].value,
                              index: index,
                              myGameId: controller.myGameId,
                              onEachButtonTap: controller.onEachButtonTap,
                              onRowTap: controller.onEachRowTap,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
