import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Controllers/queue_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_widgets/system_selection.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/queue_widgets/user_selection_data.dart';
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
            currentTurn: controller.activeIndex.value % 2 == 1 ? 1 : 2,
            systemBannedGames: controller.systemBannedGames,
          ),
          const SizedBox(height: 10),
          SystemSelectionWidget(games: controller.systemBannedGames.value),
          const SizedBox(height: 5),
          if (controller.queuers.length == 2)
            Expanded(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 5),
                      UserSelectionData(
                        player1Selection: controller.player1SelectedGame.value,
                        player2Selection: controller.player2SelectedGame.value,
                        isBan: false,
                      ),
                      const SizedBox(height: 5),
                      UserSelectionData(
                        player1Selection:
                            controller.gamer1BannedGames.length > 1
                                ? controller.gamer1BannedGames[1]
                                : null,
                        player2Selection:
                            controller.gamer2BannedGames.length > 1
                                ? controller.gamer2BannedGames[1]
                                : null,
                      ),
                      const SizedBox(height: 5),
                      if (controller.systemSelectedGame.value != null)
                        SystemSelectionWidget(
                          games: [controller.systemSelectedGame.value!],
                          isBan: false,
                        )
                      else
                        const SystemSelectionWidget(
                          games: [],
                          isBan: false,
                        )
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
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "انتخاب کنید",
                        style: TextStyle(
                            color: AppColors.lightColor, fontSize: 20),
                      ),
                    ),
                    // if (controller.selectedGameIndex.value != -1)
                    InkWell(
                      onTap: controller.sendSelection,
                      child: const Icon(
                        Icons.check,
                        color: AppColors.lightColor,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Container(
                  padding: AppSpacings.s10Vertical,
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
                              controller.changeSelectedGame(index);
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
