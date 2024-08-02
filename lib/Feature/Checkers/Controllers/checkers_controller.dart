import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Checkers/Models/checkers_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class CheckersController extends BaseGameController {
  RxList<RxList<Rx<CheckersPeaceModel>>> peaces = RxList();
  int maxRound = 2;

  @override
  void currentTurnFunction(Map data) {
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.tictactoeRoundTime);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    // Map newData = data['data'];
    // Map gameData = newData['game_data'];
    // Map timerData = newData['timer_data'];
    // List boardData = gameData['board'];
    // currentRound.value = gameData['current_round'];
    // player1Score.value = gameData['scores'][0];
    // player2Score.value = gameData['scores'][1];
    // currentTurn.value = gameData['current_turn'];
    // for (var i = 0; i < boardData.length; i++) {
    //   if (boardData[i] == 0) {
    //     continue;
    //   }
    //   peaces[i].value =
    //       peaces[i].value.changeSelectedUser(newSelectedUser: boardData[i]);
    // }
    // if (currentTurn.value == myGameId) {
    //   canSelectPeace.value = true;
    // } else {
    //   canSelectPeace.value = false;
    // }
    // if (timerData['is_user_turn']) {
    //   final int time =
    //       GameWaitTimes.tictactoeRoundTime - timerData['time'] as int;
    //   changetimerValue(time.clamp(0, time));
    // }
  }

  @override
  void peaceSelectedFunction(Map data) {
    // Map peaceData = data['data'];
    // int peaceId = peaceData['target_peace'];
    // for (final peace in peaces) {
    //   if (peace.value.id == peaceId) {
    //     peace.value =
    //         peace.value.changeSelectedUser(newSelectedUser: peaceData["user"]);
    //     removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    //     break;
    //   }
    // }
  }

  @override
  void newRoundFunction(Map data) {
    int newRound = data['data'];
    currentRound.value = newRound;
    resetPeaces();
  }

  @override
  void finishRoundFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    int roundWinner = newData['Winner'] ?? 0;
    if (roundWinner == 1) {
      player1Score.value += 1;
    } else if (roundWinner == 2) {
      player2Score.value += 1;
    }
    FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    CheckersPeaceModel peace = tappedPeace as CheckersPeaceModel;
    if (!canSelectPeace.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (peace.selectedUser != null) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    canSelectPeace.value = false;
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      // peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    // peaces.value[peaceId].value =
    // peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    // peaces.value[peaceId].value =
    // peaces.value[peaceId].value.removeStatus(status: status);
  }

  @override
  void onInit() async {
    gameType = GameTypes.tictactoe;
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
    );
    for (var i = 0; i < 8; i++) {
      for (var j = 0; i < 8; i++) {
        peaces[i].add(Rx(CheckersPeaceModel(id: i, currentStatuses: [])));
      }
    }
    super.onInit();
  }
}
