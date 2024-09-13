import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuController extends BaseController {
  RxInt currentPage = RxInt(0);

  changePage(int value) {
    currentPage.value = value;
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
