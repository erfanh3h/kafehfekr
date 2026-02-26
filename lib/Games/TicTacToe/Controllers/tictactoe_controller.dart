import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/TicTacToe/Models/tictactoe_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToeController extends BaseGameController {
  RxList<Rx<TicTacToePeaceModel>> peaces = RxList();
  int maxRound = GameRoundCounts.tictactoeRoundCount;

  @override
  void currentTurnFunction(Map data) {
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.tictactoeRoundTime);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentRound.value = gameData['current_round'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_turn'];
    for (var i = 0; i < boardData.length; i++) {
      if (boardData[i] == 0) {
        continue;
      }
      peaces[i].value =
          peaces[i].value.changeSelectedUser(newSelectedUser: boardData[i]);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    final int time =
        GameWaitTimes.tictactoeRoundTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['target_peace'];
    peaces[peaceId].value = peaces[peaceId]
        .value
        .changeSelectedUser(newSelectedUser: peaceData["user"]);
    removeAllPeaceStatus(PeaceStatusTypes.lastTurnPlayed);
    peaces[peaceId].value =
        peaces[peaceId].value.changeLastTurnPlayed(isPlayed: true);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
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
    currentTurn.value = 0;
    changetimerValue(GameWaitTimes.tictactoeSleepRoundTime);
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
    TicTacToePeaceModel peace = tappedPeace as TicTacToePeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (peace.selectedUser != null) {
      showInteraction(text: AppTexts.selectedBefore.tr);
      return;
    }
    canSelectPeace.value = false;
    showInteraction(sound: GameSoundTypes.tap);
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  void addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  void removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  void removeAllPeaceStatus(PeaceStatusTypes status) {
    for (var i = 0; i < 9; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  void initPieces() {
    for (var i = 0; i < 9; i++) {
      peaces.add(Rx(TicTacToePeaceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.TicTacToe;
    initPieces();
  }
}
