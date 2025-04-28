import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Network/queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuController extends BaseController {
  RxBool isQueueActive = RxBool(false);
  RxBool isQueueLoading = RxBool(false);

  RxBool isPreGameMode = RxBool(false);

  void onQueueStarted() {
    isQueueLoading.value = false;
  }

  void onQueueError() {
    stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void startQueue() {
    if (isQueueActive.value) {
      DialogComponent().showToast(label: AppTexts.stopPrevoiusQueue.tr);
      return;
    }
    isQueueActive.value = true;
    isQueueLoading.value = true;
    final userId = Get.find<GlobalController>().userId ?? "";
    Get.put(QueueSocketManager());
    Get.find<QueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      myId: userId,
      onQueueStart: onQueueStarted,
      onQueueError: onQueueError,
    );
    // activeQueueType.value = gameType;
    // activeQueueScoreType.value = gameScoreType;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        isQueueActive.value = true;
        final String gameId = data['data']['game_id'];
        const String gameType = 'activeQueueType.value';
        Get.find<GlobalController>().setActiveGameId(gameId, gameType);
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.queueFinded);
        Get.toNamed(AppRoutes.gamePlay, arguments: gameId);
        Get.find<SoundPlayerComponent>().startPlayMusic(isGame: true);
        Future.delayed(const Duration(seconds: 1)).then((_) {
          // Get.toNamed('/$gameType', arguments: gameId);
          stopQueue();
        });
        break;
      case GameCommands.notEnoughCoin:
        DialogComponent().showToast(label: AppTexts.notEnoughCoin.tr);
        stopQueue();
      case GameCommands.startPreGame:
        isPreGameMode.value = true;
      default:
    }
  }

  void stopQueue() {
    // Get.find<QueueSocketManager>().disconnect();
    Get.delete<QueueSocketManager>();
    isQueueActive.value = false;
    isQueueLoading.value = false;
    // activeQueueType.value = "";
    // activeQueueScoreType.value = "";
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
    }
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  @override
  void onInit() {
    startQueue();
    super.onInit();
  }
}
