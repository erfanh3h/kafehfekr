import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/queue_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/users_data_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class QueueGameSelectionPart extends StatelessWidget {
  const QueueGameSelectionPart({super.key, required this.controller});

  final QueueController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 10),
          GamersDataWidget(
            player1Data: controller.queuers[0],
            player2Data: controller.queuers[1],
            currentTurn: 0,
            systemBannedGames: controller.systemBannedGames,
          ),
          const SizedBox(height: 10),
          SystemSelectionWidget(
              label: 'بن ابتدایی : ',
              games: controller.systemBannedGames.value),
          if (controller.queuers.length == 2)
            Expanded(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (controller.gamer1BannedGames.isNotEmpty ||
                          controller.gamer2BannedGames.isNotEmpty)
                        UserSelectionData(
                          player1Selection:
                              controller.gamer1BannedGames.isNotEmpty
                                  ? controller.gamer1BannedGames[0]
                                  : null,
                          player2Selection:
                              controller.gamer2BannedGames.isNotEmpty
                                  ? controller.gamer2BannedGames[0]
                                  : null,
                        ),
                      if (controller.player1SelectedGame.value != null ||
                          controller.player2SelectedGame.value != null)
                        UserSelectionData(
                          player1Selection:
                              controller.player1SelectedGame.value,
                          player2Selection:
                              controller.player2SelectedGame.value,
                        ),
                      if (controller.gamer1BannedGames.length > 1 ||
                          controller.gamer2BannedGames.length > 1)
                        UserSelectionData(
                          player1Selection: controller.gamer1BannedGames[1],
                          player2Selection: controller.gamer2BannedGames[1],
                        ),
                      if (controller.systemSelectedGame.value != null)
                        SystemSelectionWidget(
                          label: 'بازی انتخابی رندوم : ',
                          games: [controller.systemSelectedGame.value!],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          if (controller.letSelectGame.value)
            Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("انتخاب کنید")),
                    GlobalButtonWidget(
                      onTap: controller.sendSelection,
                      text: AppTexts.accept.tr,
                    ),
                  ],
                ),
                Container(
                  padding: AppSpacings.s10All,
                  height: 100,
                  child: Obx(
                    () => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => Obx(
                        () => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: controller.selectedGameIndex.value == index
                                ? Border.all(
                                    color: AppColors.lightColor, width: 3)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GameButtonWidget(
                            onTap: () {
                              controller.selectedGameIndex.value = index;
                            },
                            image: GameTypeConvertor(
                                    gameType: controller.allGames[index])
                                .toGameImage(),
                            text: controller.allGames[index].name,
                            imageColor: null,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        width: 5,
                      ),
                      itemCount: controller.allGames.length,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class SystemSelectionWidget extends StatelessWidget {
  const SystemSelectionWidget({
    super.key,
    required this.label,
    required this.games,
  });

  final String label;
  final List<GameTypes> games;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.tr,
            style: const TextStyle(color: AppColors.lightColor, fontSize: 20),
          ),
          const SizedBox(width: 5),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => SizedBox(
              width: 50,
              height: 50,
              child: GameButtonWidget(
                onTap: () {},
                image: GameTypeConvertor(gameType: games[index]).toGameImage(),
                text: games[index].name,
                imageColor: null,
                fontSize: 15,
              ),
            ),
            separatorBuilder: (ctx, index) => const SizedBox(
              width: 5,
            ),
            itemCount: games.length,
          ),
        ],
      ),
    );
  }
}

class UserSelectionData extends StatelessWidget {
  const UserSelectionData({
    super.key,
    required this.player1Selection,
    required this.player2Selection,
  });

  final GameTypes? player1Selection;
  final GameTypes? player2Selection;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: player1Selection != null
              ? GameButtonWidget(
                  onTap: () {},
                  image: GameTypeConvertor(gameType: player1Selection!)
                      .toGameImage(),
                  text: player1Selection!.name,
                  imageColor: null,
                  fontSize: 15,
                )
              : const Card(),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: player2Selection != null
              ? GameButtonWidget(
                  onTap: () {},
                  image: GameTypeConvertor(gameType: player2Selection!)
                      .toGameImage(),
                  text: player2Selection!.name,
                  imageColor: null,
                  fontSize: 15,
                )
              : const Card(),
        ),
      ],
    );
  }
}
