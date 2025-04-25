import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class BaseOfflineGameController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();
  late String gameId;

  // RxBool canSelectPeace = RxBool(false);

  RxInt currentRound = RxInt(1);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  RxInt currentTurn = RxInt(1);

  RxBool isGameStarted = RxBool(false);
  RxBool isGameFinished = RxBool(false);
  RxString gameResultText = RxString("");

  late GameTypes gameType;

  changeActiveTrun() {
    if (currentTurn.value == 1) {
      currentTurn.value = 2;
    } else {
      currentTurn.value = 1;
    }
  }
  // void commandHandler(dynamic data) {
  //   final commandId = data['id'];
  //   switch (commandId) {
  //     case GameCommands.gameData:
  //       gameDataFunction(data);
  //       break;
  //     case GameCommands.startGame:
  //       isPageLoading.value = false;
  //       startGameFunction(data);
  //       break;
  //     case GameCommands.currentTurn:
  //       isPageLoading.value = false;
  //       currentTurnFunction(data);
  //       break;
  //     case GameCommands.selectPeaceResult:
  //       selectPeaceResult(data);
  //       break;
  //     case GameCommands.peaceSelected:
  //       peaceSelectedFunction(data);
  //       break;
  //     case GameCommands.peaceSwaped:
  //       peaceSwapedFunction(data);
  //       break;
  //     case GameCommands.peaceRemoved:
  //       peaceRemovedFunction(data);
  //       break;
  //     case GameCommands.selectRemovePeace:
  //       selectRemovePeaceFunction(data);
  //       break;
  //     case GameCommands.newRound:
  //       newRoundFunction(data);
  //       break;
  //     case GameCommands.newTurnRound:
  //       newTurnRoundFunction(data);
  //       break;
  //     case GameCommands.finishRound:
  //       finishRoundFunction(data);
  //       break;
  //     case GameCommands.finishTurnRound:
  //       finishTurnRoundFunction(data);
  //       break;
  //     case GameCommands.finishGame:
  //       finishGameFunction(data);
  //       break;
  //     case GameCommands.playerScore:
  //       playerScoreFunction(data);
  //       break;
  //     case GameCommands.gameFinished:
  //       // Get.find<GamePlayController>().deviceFinishGameFunction();
  //       break;
  //     case GameCommands.gamePlayData:
  //       // Get.find<GamePlayController>().gamePlayDataFunction(data);
  //       break;
  //     case GameCommands.gamePlayNavigate:
  //       // Get.find<GamePlayController>().navigateToGameFunction(data);
  //       break;
  //     case GameCommands.gamePlayTime:
  //       // Get.find<GamePlayController>().changeTimeFunction(data);
  //       break;
  //     default:
  //   }
  // }

  // void currentTurnFunction(Map data) {}

  // void startGameFunction(Map data) {}

  // void peaceSelectedFunction(Map data) {}

  // void peaceSwapedFunction(Map data) {}

  // void peaceRemovedFunction(Map data) {}

  // void selectRemovePeaceFunction(Map data) {}

  // void newRoundFunction(Map data) {}

  // void newTurnRoundFunction(Map data) {}

  // void selectPeaceResult(Map data) {}

  // void finishRoundFunction(Map data) {}

  // void finishTurnRoundFunction(Map data) {}

  // void playerScoreFunction(Map data) {}

  // void onEachButtonTap(dynamic tappedPeace) {}

  void gameDataFunction(Map data) async {
    isPageLoading.value = false;
    // Map gameData = data['data'];
    // List gamers = gameData['gamers'];
    // for (var gamerData in gamers) {
    //   PlayerModel newPlayer = PlayerModel.fromJson(gamerData);
    //   players.add(Rx(newPlayer));
    //   if (newPlayer.userId == myId) {
    //     myGameId = newPlayer.gamerId;
    //   }
    // }
    for (var i = 0; i < 5; i++) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.time);
      await Future.delayed(const Duration(seconds: 1));
    }
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.bell);
    isGameStarted.value = true;
  }

  void finishGameFunction(Map data) {
    isGameFinished.value = true;
    // canSelectPeace.value = false;
    // Map newData = data['data'];
    // FunctionsLibraryClass.showFinishGameDialog(
    //   newData['Winner'],
    //   myGameId,
    //   gameType,
    // );
  }

  bool isThisUserTurn(int gamerId) {
    return currentTurn.value == gamerId;
  }

  void nextUser(dynamic data) {}

  void showInfo() {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  void showInteraction({String? text, GameSoundTypes? sound}) {
    Get.find<SoundPlayerComponent>()
        .playGameSound(sound ?? GameSoundTypes.tapWrong);
    if (text != null) {
      DialogComponent().showToast(label: text);
    }
  }

  String getActiveGamerUsername() {
    // if (currentTurn.value == 1) {
    //   return players[0].value.name;
    // }
    // if (currentTurn.value == 2) {
    //   return players[1].value.name;
    // }
    return "";
  }

  String getInActiveGamerUsername() {
    // if (currentTurn.value == 1) {
    //   return players[1].value.name;
    // }
    // if (currentTurn.value == 2) {
    //   return players[0].value.name;
    // }
    return "";
  }

  resetGame() {}
  exitGame() {
    Get.back();
  }

  @override
  void onInit() {
    Get.find<SoundPlayerComponent>().stopMusic();
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    Get.find<SoundPlayerComponent>().startPlayMusic();
    super.onClose();
  }
}
