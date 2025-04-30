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
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class QueueController extends BaseController {
  RxBool isQueueActive = RxBool(false);
  RxBool isQueueLoading = RxBool(false);
  RxBool isPreGameMode = RxBool(false);

  RxList<QueuerModel> queuers = RxList([]);
  RxList<GameTypes> systemBannedGames = RxList();
  Rx<GameTypes?> systemSelectedGame = Rx(null);
  RxList<GameTypes> gamer1BannedGames = RxList();
  RxList<GameTypes> gamer2BannedGames = RxList();
  Rx<GameTypes?> player1SelectedGame = Rx(null);
  Rx<GameTypes?> player2SelectedGame = Rx(null);

  RxList<GameTypes> allGames = RxList();

  RxInt selectedGameIndex = RxInt(-1);
  RxInt activeIndex = RxInt(0);

  late String myId;
  String? preGameId;

  RxBool letSelectGame = RxBool(false);
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
    for (var element in GameTypes.values) {
      allGames.add(element);
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
        Get.offNamed(AppRoutes.gamePlay, arguments: gameId);
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
        // Get.find<SoundPlayerComponent>().stopMusic();
        Get.find<SoundPlayerComponent>().startPlayQueueMusic();
        showInteraction(sound: GameSoundTypes.startGame);
        List queuersData = data['data']['queuers'];
        for (var queuer in queuersData) {
          queuers.add(QueuerModel.fromJson(queuer));
        }
        DialogComponent().showTimerDialog(time: 5);
        isPreGameMode.value = true;
        preGameId = data['data']['id'];
      case GameCommands.systemBannedGames:
        List<String> newData = List<String>.from(data['data']);
        for (var rawData in newData) {
          final gameValue = stringToGameType(rawData);
          allGames.remove(gameValue);
          systemBannedGames.add(gameValue);
        }
        activeIndex.value += 1;
      case GameCommands.selectedGame:
        final gameType = data['data']['game_type'];
        activeIndex.value = data['data']['active_index'];
        switch (activeIndex.value) {
          case 1:
            gamer1BannedGames.add(stringToGameType(gameType));
          case 2:
            gamer2BannedGames.add(stringToGameType(gameType));
          case 3:
            player1SelectedGame.value = stringToGameType(gameType);
          case 4:
            player2SelectedGame.value = stringToGameType(gameType);
          case 5:
            gamer1BannedGames.add(stringToGameType(gameType));
          case 6:
            gamer2BannedGames.add(stringToGameType(gameType));
          case 7:
            systemSelectedGame.value = stringToGameType(gameType);
            DialogComponent().showTimerDialog(time: 5);
        }
        final gameValue = stringToGameType(gameType);
        allGames.remove(gameValue);
        update();
        activeIndex.value += 1;
      case GameCommands.selectGame:
        final targetId = data['data'];
        if (targetId == myId) {
          showInteraction(sound: GameSoundTypes.startTurn);
          letSelectGame.value = true;
        }
      default:
    }
  }

  void sendCommand(Map data) {
    Get.find<QueueSocketManager>().sendCommand(data);
  }

  sendSelection() {
    if (selectedGameIndex.value == -1) {
      DialogComponent().showToast(label: AppTexts.selectGameTypeFirst.tr);
      return;
    }
    letSelectGame.value = false;
    final selectedGameType = allGames[selectedGameIndex.value];
    selectedGameIndex.value = -1;
    sendCommand({
      'id': GameCommands.selectGame,
      'game_type': selectedGameType.name,
      'pre_game_id': preGameId,
    });
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

  void showInteraction({String? text, GameSoundTypes? sound}) {
    Get.find<SoundPlayerComponent>()
        .playGameSound(sound ?? GameSoundTypes.tapWrong);
    if (text != null) {
      DialogComponent().showToast(label: text);
    }
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  changeSelectedGame(int index) {
    if (selectedGameIndex.value == index) {
      selectedGameIndex.value = -1;
    } else {
      selectedGameIndex.value = index;
    }
  }

  @override
  void onInit() {
    startQueue();
    myId = Get.find<GlobalController>().userId!;
    super.onInit();
  }
}
