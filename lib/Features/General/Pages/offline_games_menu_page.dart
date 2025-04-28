import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Features/General/Controllers/offline_games_menu_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/offline_menu_game_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class OfflineGamesMenuPage extends BaseView<OfflineGamesMenuController> {
  const OfflineGamesMenuPage({super.key});

  @override
  Widget body(BuildContext context) {
    List<GameTypes> gameTypesParts = [];
    for (var gameType in OfflineGameTypes.values) {
      gameTypesParts.add(GameTypeConvertor.offlineGameToOnlineGame(gameType));
    }
    final int gamesLength = gameTypesParts.length;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      padding: AppSpacings.s10Horizental,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.offlineGame.tr,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.lightColor,
                  ),
                ),
              ),
              backButton
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FadeIn(
              child: ListView.separated(
                itemBuilder: (ctx, index) => OfflineMenuGamePartWidget(
                  game: gameTypesParts[index],
                  onTap: controller.onEachGameTap,
                  onOpenGuide: controller.openGameGuide,
                ),
                separatorBuilder: (ctx, index) => const SizedBox(height: 25),
                itemCount: gamesLength,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
