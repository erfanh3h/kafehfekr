import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuController extends BaseController {
  RxInt selectedTab = RxInt(0);

  RxInt normalCurrentPage = RxInt(0);
  final PageController normalPageController = PageController();

  RxList<GameTypes> selectedRankGames = RxList([]);
  changeTab(int value) {
    selectedTab.value = value;
    if (value == 0) {
      normalCurrentPage.value = 0;
    }
  }

  changeNormalPage(int value) {
    normalCurrentPage.value = value;
  }

  onEachRankGameTap(GameTypes game) {
    if (selectedRankGames.contains(game)) {
      selectedRankGames.remove(game);
    } else {
      if (selectedRankGames.length >= 5) {
        return;
      }
      selectedRankGames.add(game);
    }
  }

  Color getGameColor(int index) {
    final GameDifficulties difficulty =
        GameTypeConvertor(gameType: GameTypes.values[index])
            .toGameDifficallty();
    switch (difficulty) {
      case GameDifficulties.Easy:
        return AppColors.darkGreen;
      case GameDifficulties.Normal:
        return AppColors.yellow;
      case GameDifficulties.Hard:
        return AppColors.buttonRed;
      default:
        return AppColors.green;
    }
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  startRankGame() {
    if (selectedRankGames.length < 5) {
      DialogComponent().showToast(label: AppTexts.select5Games.tr);
      return;
    }
  }

  startNormalGame(GameTypes game) {
    Get.find<GlobalController>().startQueue('', '');
    // onTap(game.name, "Normal");
  }

  @override
  void onInit() {
    super.onInit();
  }
}
