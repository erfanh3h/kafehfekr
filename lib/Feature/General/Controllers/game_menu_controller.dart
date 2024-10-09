import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuController extends BaseController {
  RxInt selectedTab = RxInt(0);

  RxInt normalCurrentPage = RxInt(0);
  final PageController normalPageController = PageController();

  RxList<GameTypes> selectedNormalGames = RxList([]);
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
    if (Get.find<GlobalController>().isQueueActive.value) {
      DialogComponent().showToast(label: AppTexts.stopPrevoiusQueue.tr);
      return;
    }
    if (selectedRankGames.contains(game)) {
      selectedRankGames.remove(game);
    } else {
      if (selectedRankGames.length >= 5) {
        return;
      }
      selectedRankGames.add(game);
    }
  }

  onEachNormalGameTap(GameTypes game) {
    if (Get.find<GlobalController>().isQueueActive.value) {
      DialogComponent().showToast(label: AppTexts.stopPrevoiusQueue.tr);
      return;
    }
    if (selectedNormalGames.contains(game)) {
      selectedNormalGames.remove(game);
    } else {
      if (selectedNormalGames.length >= 2) {
        return;
      }
      selectedNormalGames.add(game);
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
    List<String> gameTypes = [];
    for (var gameType in selectedRankGames) {
      gameTypes.add(gameType.name);
    }
    Get.find<GlobalController>().startQueue(gameTypes, 'Rank');
  }

  startNormalGame() {
    if (selectedNormalGames.length < 2) {
      DialogComponent().showToast(label: AppTexts.select2Games.tr);
      return;
    }
    List<String> gameTypes = [];
    for (var gameType in selectedNormalGames) {
      gameTypes.add(gameType.name);
    }
    Get.find<GlobalController>().startQueue(gameTypes, 'Normal');
  }

  goToLobbiesPage() {
    Get.toNamed(AppRoutes.lobby);
  }

  // startNormalGame(GameTypes game) {
  //   Get.find<GlobalController>().startQueue([game.name], 'Normal');
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
