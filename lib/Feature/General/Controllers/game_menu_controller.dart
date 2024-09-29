import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuController extends BaseController {
  RxInt selectedTab = RxInt(0);

  RxInt normalCurrentPage = RxInt(0);
  final PageController normalPageController = PageController();

  changeTab(int value) {
    selectedTab.value = value;
  }

  changeNormalPage(int value) {
    normalCurrentPage.value = value;
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

  @override
  void onInit() {
    super.onInit();
  }
}
