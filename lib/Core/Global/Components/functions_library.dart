import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/user_data_widget.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class FunctionsLibraryClass {
  static void showFinishGameDialog(
      int gameWinner, int myGameId, GameTypes gameType) {
    if (gameWinner == 0) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.draw);
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        AppTexts.gameDrawed.tr,
        GeneralIcons.draw,
        AppColors.drawColor,
        letBackPage: false,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      if (gameWinner == myGameId) {
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
        dialogMessage = AppTexts.youWinGame.tr;
        dialogIcon = GeneralIcons.win;
        dialogColor = AppColors.winColor;
      } else {
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
        dialogMessage = AppTexts.youLoseGame.tr;
        dialogIcon = GeneralIcons.lose;
        dialogColor = AppColors.loseColor;
      }
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        dialogMessage,
        dialogIcon,
        dialogColor,
        letBackPage: false,
      );
    }
  }

  static void showSurrenderDialog(
      int gamerId, int myGameId, GameTypes gameType) {
    String dialogMessage = "";
    String dialogIcon = "";
    Color dialogColor = Colors.white;
    if (gamerId == myGameId) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
      dialogMessage = AppTexts.youSurrenderGame.tr;
      dialogIcon = GeneralIcons.lose;
      dialogColor = AppColors.loseColor;
    } else {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
      dialogMessage = AppTexts.enemySurrenderGame.tr;
      dialogIcon = GeneralIcons.win;
      dialogColor = AppColors.winColor;
    }
    DialogComponent().showIconicDialog(
      AppTexts.endGame.tr,
      dialogMessage,
      dialogIcon,
      dialogColor,
    );
  }

  static void showFinishReconnectTimeDialog(
      String userId, String myId, GameTypes gameType) {
    String dialogMessage = "";
    String dialogIcon = "";
    Color dialogColor = Colors.white;
    if (userId == myId) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
      dialogMessage = AppTexts.youSurrenderGame.tr;
      dialogIcon = GeneralIcons.lose;
      dialogColor = AppColors.loseColor;
    } else {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
      dialogMessage = AppTexts.enemySurrenderGame.tr;
      dialogIcon = GeneralIcons.win;
      dialogColor = AppColors.winColor;
    }
    DialogComponent().showIconicDialog(
      AppTexts.endGame.tr,
      dialogMessage,
      dialogIcon,
      dialogColor,
    );
  }

  static void showFinishRoundDialog(int roundWinner, int myGameId) {
    if (roundWinner == 0) {
      DialogComponent().showIconicDialog(
        AppTexts.endRound.tr,
        AppTexts.roundDrawed.tr,
        GeneralIcons.drawRound,
        AppColors.drawColor,
        letBackPage: false,
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
        letBackPage: false,
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

  static bool isVersionOk(String currentVersion, String newVersion) {
    int currnetVersionPart1Number = int.parse(currentVersion.split(".")[0]);
    int currnetVersionPart2Number = int.parse(currentVersion.split(".")[1]);
    int currnetVersionPart3Number = int.parse(currentVersion.split(".")[2]);
    int newVersionPart1Number = int.parse(newVersion.split(".")[0]);
    int newVersionPart2Number = int.parse(newVersion.split(".")[1]);
    int newVersionPart3Number = int.parse(newVersion.split(".")[2]);
    if (newVersionPart1Number > currnetVersionPart1Number) {
      return false;
    }
    if (newVersionPart1Number == currnetVersionPart1Number &&
        newVersionPart2Number > currnetVersionPart2Number) {
      return false;
    }
    if (newVersionPart1Number == currnetVersionPart1Number &&
        newVersionPart2Number == currnetVersionPart2Number &&
        newVersionPart3Number > currnetVersionPart3Number) {
      return false;
    }
    return true;
  }

  static showUserData(String userId) {
    final repo = GlobalRepository();
    repo.getUserData(userId: userId).then((result) {
      if (result.resultData != null) {
        Get.bottomSheet(
          UserDataWidget(
            userData: result.resultData!.$1!,
            userHistoryData: result.resultData!.$2!,
          ),
          backgroundColor: AppColors.darkColor,
        );
      }
    });
  }

  static Future<String> getDeviceId() async {
    String result = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      result = info.id;
    } else if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      result = info.deviceId;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      result = info.identifierForVendor!;
    } else {
      final info = await deviceInfo.webBrowserInfo;
      result = info.userAgent!;
    }
    return result;
  }

  static int totalExpToLevel(int level, {int base = 20}) {
    return (base * (level * level)).toInt();
  }

// exp = base(20) * lvl^2
  static int expToLevel(int exp, {int base = 20}) {
    if (exp < base) {
      return 0;
    }
    int level = 1;
    while (totalExpToLevel(level + 1, base: base) <= exp) {
      level += 1;
    }
    return level;
  }

  static double expPercent(int exp) {
    final level = expToLevel(exp);
    int currentLevelTotalExp = totalExpToLevel(level);
    int nextLevelTotalExp = totalExpToLevel(level + 1);
    int expInCurrentLevel = exp - currentLevelTotalExp;
    int totalNeededInThisLevel = nextLevelTotalExp - currentLevelTotalExp;
    return clampDouble(expInCurrentLevel / totalNeededInThisLevel, .01, 1);
  }
}
