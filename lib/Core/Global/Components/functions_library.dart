import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class FunctionsLibraryClass {
  void showFinishGameDialog(int gameWinner, int myGameId, GameTypes gameType) {
    if (gameWinner == 0) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.draw);
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        AppTexts.gameDrawed.tr,
        GeneralIcons.draw,
        AppColors.drawColor,
        coin: 0,
        cup: 0,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      int cup = 0;
      int coin = 0;
      if (gameWinner == myGameId) {
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
        dialogMessage = AppTexts.youWinGame.tr;
        dialogIcon = GeneralIcons.win;
        dialogColor = AppColors.winColor;
        switch (gameType) {
          case GameTypes.tictactoe:
            cup = CupsCount.tictactoeWin;
            coin = CoinsCount.tictactoeWin;
            break;
          case GameTypes.rpc:
            cup = CupsCount.rpcWin;
            coin = CoinsCount.rpcWin;
            break;
          case GameTypes.mill:
            cup = CupsCount.millWin;
            coin = CoinsCount.millWin;
            break;
          case GameTypes.msweeper:
            cup = CupsCount.msweeperWin;
            coin = CoinsCount.msweeperWin;
            break;
          default:
        }
      } else {
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
        dialogMessage = AppTexts.youLoseGame.tr;
        dialogIcon = GeneralIcons.lose;
        dialogColor = AppColors.loseColor;
        switch (gameType) {
          case GameTypes.tictactoe:
            cup = CupsCount.tictactoeLose;
            coin = CoinsCount.tictactoeLose;
            break;
          case GameTypes.rpc:
            cup = CupsCount.rpcLose;
            coin = CoinsCount.rpcLose;
            break;
          case GameTypes.mill:
            cup = CupsCount.millLose;
            coin = CoinsCount.millLose;
            break;
          case GameTypes.msweeper:
            cup = CupsCount.msweeperLose;
            coin = CoinsCount.msweeperLose;
            break;
          default:
        }
      }
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        dialogMessage,
        dialogIcon,
        dialogColor,
        coin: coin,
        cup: cup,
      );
    }
  }

  static void showSurrenderDialog(
      int gamerId, int myGameId, GameTypes gameType) {
    String dialogMessage = "";
    String dialogIcon = "";
    Color dialogColor = Colors.white;
    int cup = 0;
    int coin = 0;
    if (gamerId == myGameId) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
      dialogMessage = AppTexts.youSurrenderGame.tr;
      dialogIcon = GeneralIcons.lose;
      dialogColor = AppColors.loseColor;
      switch (gameType) {
        case GameTypes.tictactoe:
          cup = CupsCount.tictactoeLose;
          coin = CoinsCount.tictactoeLose;
          break;
        case GameTypes.rpc:
          cup = CupsCount.rpcLose;
          coin = CoinsCount.rpcLose;
          break;
        case GameTypes.mill:
          cup = CupsCount.millLose;
          coin = CoinsCount.millLose;
          break;
        case GameTypes.msweeper:
          cup = CupsCount.msweeperLose;
          coin = CoinsCount.msweeperLose;
          break;
        default:
      }
    } else {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
      dialogMessage = AppTexts.enemySurrenderGame.tr;
      dialogIcon = GeneralIcons.win;
      dialogColor = AppColors.winColor;
      switch (gameType) {
        case GameTypes.tictactoe:
          cup = CupsCount.tictactoeWin;
          coin = CoinsCount.tictactoeWin;
          break;
        case GameTypes.rpc:
          cup = CupsCount.rpcWin;
          coin = CoinsCount.rpcWin;
          break;
        case GameTypes.mill:
          cup = CupsCount.millWin;
          coin = CoinsCount.millWin;
          break;
        case GameTypes.msweeper:
          cup = CupsCount.msweeperWin;
          coin = CoinsCount.msweeperWin;
          break;
        default:
      }
    }
    DialogComponent().showIconicDialog(
      AppTexts.endGame.tr,
      dialogMessage,
      dialogIcon,
      dialogColor,
      coin: coin,
      cup: cup,
    );
  }

  static void showFinishRoundDialog(int roundWinner, int myGameId) {
    if (roundWinner == 0) {
      DialogComponent().showIconicDialog(
        AppTexts.endRound.tr,
        AppTexts.roundDrawed.tr,
        GeneralIcons.drawRound,
        AppColors.drawColor,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      if (roundWinner == myGameId) {
        dialogMessage = AppTexts.youWinThisRound.tr;
        dialogIcon = GeneralIcons.happy;
        dialogColor = AppColors.winColor;
      } else {
        dialogMessage = AppTexts.youLoseThisRound.tr;
        dialogIcon = GeneralIcons.sad;
        dialogColor = AppColors.loseColor;
      }
      DialogComponent().showIconicDialog(
        AppTexts.endRound.tr,
        dialogMessage,
        dialogIcon,
        dialogColor,
      );
    }
  }

  static void surrenderFunction() {
    DialogComponent().showIconicSelectionDialog(
      AppTexts.surrender.tr,
      AppTexts.wanaSurrenderGame.tr,
      GeneralIcons.death,
      AppColors.loseColor,
      () {
        Get.find<GameSocketManager>()
            .sendCommand({"id": GameCommands.surrender});
        Get.closeAllDialogs();
      },
      () {
        Get.closeAllDialogs();
      },
    );
  }
}
