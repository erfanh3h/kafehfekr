import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/RPC/Models/rpc_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class RPCController extends BaseGameController {
  RxList<Rx<RPCPeaceModel>> peaces = RxList();

  RxBool peaceSelected = RxBool(false);

  RxInt currentTurnRound = RxInt(1);

  int maxRound = GameRoundCounts.rpcRoundCount;
  int maxTurnRound = GameRoundCounts.rpcTurnRoundCount;

  RxInt player1TotalScore = RxInt(0);
  RxInt player2TotalScore = RxInt(0);

  RxInt player1RoundScore = RxInt(0);
  RxInt player2RoundScore = RxInt(0);

  Rx<RPCPeaceTypes> selectedPeace = Rx(RPCPeaceTypes.rock);

  Rx<RPCPeaceTypes?> player1SelectedPeace = Rx(null);
  Rx<RPCPeaceTypes?> player2SelectedPeace = Rx(null);
  RxInt thisTurnRoundWinner = RxInt(0);

  @override
  void newTurnRoundFunction(Map data) {
    resetPeaces();
    showInteraction(sound: GameSoundTypes.startTurn);
  }

  @override
  void finishTurnRoundFunction(Map data) {
    peaceSelected.value = true;
    Map turnData = data['data'];
    int turnRoundWinner = turnData['Winner'];
    player1SelectedPeace.value = RPCPeaceTypes.values
        .byName(turnData['P1_selection'] ?? RPCPeaceTypes.rock.name);
    player2SelectedPeace.value = RPCPeaceTypes.values
        .byName(turnData['P2_selection'] ?? RPCPeaceTypes.rock.name);
    thisTurnRoundWinner.value = turnRoundWinner;
    changetimerValue(GameWaitTimes.rpcSleepRoundTime);
    if (currentTurnRound.value + 1 <= maxTurnRound) {
      currentTurnRound.value = currentTurnRound.value + 1;
    }
    if (turnRoundWinner == 1) {
      player1RoundScore.value += 1;
    } else if (turnRoundWinner == 2) {
      player2RoundScore.value += 1;
    }
  }

  @override
  void finishRoundFunction(Map data) {
    int roundWinner = data['data']['Winner'];
    changetimerValue(GameWaitTimes.rpcSleepRoundTime);
    player1RoundScore.value = 0;
    player2RoundScore.value = 0;
    currentRound.value += 1;
    currentTurnRound.value = 1;
    currentTurn.value = 0;
    FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
    if (roundWinner == 1) {
      player1TotalScore.value += 1;
    } else if (roundWinner == 2) {
      player2TotalScore.value += 1;
    }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    currentRound.value = gameData['current_round'];
    currentTurnRound.value = gameData['current_turn__round'];
    player1RoundScore.value = gameData['round_scores'][0];
    player2RoundScore.value = gameData['round_scores'][1];
    player1TotalScore.value = gameData['total_scores'][0];
    player2TotalScore.value = gameData['total_scores'][1];
    final int time = GameWaitTimes.rpcRoundTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    showInteraction(sound: GameSoundTypes.tap);
    RPCPeaceModel peace = tappedPeace as RPCPeaceModel;
    clearStatusFromPeaces(PeaceStatusTypes.selected);
    addPeaceStatus(peace.id, PeaceStatusTypes.selected);
    selectedPeace.value = peace.peaceType;
  }

  @override
  Color? returnTimerColor() {
    return null;
  }

  void resetPeaces() {
    peaceSelected.value = false;
    player1SelectedPeace.value = null;
    player2SelectedPeace.value = null;
    thisTurnRoundWinner.value = 0;
    clearStatusFromPeaces(PeaceStatusTypes.selected);
    addPeaceStatus(0, PeaceStatusTypes.selected);
    selectedPeace.value = RPCPeaceTypes.rock;
    peaceSelected.value = false;
    changetimerValue(GameWaitTimes.rpcRoundTime);
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  clearStatusFromPeaces(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  void acceptSelection() {
    sendCommand(
        {"id": GameCommands.selectPeace, "data": selectedPeace.value.name});
    peaceSelected.value = true;
  }

  bool isThisGamerIdThisTurnRoundWinner(int gamerId) {
    return gamerId == thisTurnRoundWinner.value;
  }

  initPieces() {
    peaces.add(
      Rx(
        RPCPeaceModel(
          id: 0,
          currentStatuses: [PeaceStatusTypes.selected],
          peaceType: RPCPeaceTypes.rock,
        ),
      ),
    );
    peaces.add(
      Rx(
        RPCPeaceModel(
          id: 1,
          currentStatuses: [],
          peaceType: RPCPeaceTypes.paper,
        ),
      ),
    );
    peaces.add(
      Rx(
        RPCPeaceModel(
          id: 2,
          currentStatuses: [],
          peaceType: RPCPeaceTypes.cutter,
        ),
      ),
    );
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.RPC;
    initPieces();
  }
}
