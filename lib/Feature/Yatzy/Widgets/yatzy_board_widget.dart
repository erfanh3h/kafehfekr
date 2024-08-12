import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_button.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_header_button.dart';
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
            padding: AppSpacings.s10All,
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              YatzyHeaderButton(
                                image: headerImages[0],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[1],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[2],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[3],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[4],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[5],
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              YatzyButton(
                                pieceData: controller.player1Pieces[0].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[1].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[2].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[3].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[4].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[5].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              YatzyButton(
                                pieceData: controller.player2Pieces[0].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[1].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[2].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[3].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[4].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[5].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              YatzyHeaderButton(
                                image: headerImages[6],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[7],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[8],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[9],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[10],
                                onTap: () {},
                              ),
                              const SizedBox(height: 5),
                              YatzyHeaderButton(
                                image: headerImages[11],
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              YatzyButton(
                                pieceData: controller.player1Pieces[6].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[7].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[8].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[9].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[10].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player1Pieces[11].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              YatzyButton(
                                pieceData: controller.player2Pieces[6].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[7].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[8].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[9].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[10].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                              const SizedBox(height: 5),
                              YatzyButton(
                                pieceData: controller.player2Pieces[11].value,
                                onTap: controller.onEachButtonTap,
                                myGameId: controller.myGameId,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
