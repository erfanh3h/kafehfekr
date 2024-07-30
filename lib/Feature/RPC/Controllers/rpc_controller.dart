import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reactions_box.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/RPC/Models/rpc_peace_model.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class RPCController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();
  RxList<Rx<RPCPeaceModel>> peaces = RxList();

  int myId = 1;
  int myGameId = 2;
  String gameId = "gameId";

  RxBool peaceSelected = RxBool(false);

  RxBool showReactions = RxBool(true);

  RxBool letSendReaction = RxBool(true);

  RxInt currentRound = RxInt(1);
  int maxRound = 2;

  RxInt currentTurnRound = RxInt(1);
  int maxTurnRound = 5;

  RxInt player1TotalScore = RxInt(0);
  RxInt player2TotalScore = RxInt(0);

  RxInt player1RoundScore = RxInt(0);
  RxInt player2RoundScore = RxInt(0);

  Rx<RPCPeaceTypes> selectedPeace = Rx(RPCPeaceTypes.rock);

  Rx<RPCPeaceTypes?> player1SelectedPeace = Rx(null);
  Rx<RPCPeaceTypes?> player2SelectedPeace = Rx(null);
  RxInt thisTurnRoundWinner = RxInt(0);

  void reactionHandler(dynamic data) {
    final Map reactionData = data;
    final playerId = reactionData['playerId'];
    final reactionId = reactionData['reactionId'];
    changePlayerReaction(playerId, reactionId);
  }

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gameData:
        Map gameData = data['data'];
        List gamers = gameData['gamers'];
        for (var gamerData in gamers) {
          players.add(Rx(PlayerModel.fromJson(gamerData)));
        }
        break;
      case GameCommands.reconnectData:
        Map newData = data['data'];
        getReconnectData(newData);
        break;
      case GameCommands.newTurnRound:
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.startTurn);
        resetPeaces();
        break;
      case GameCommands.finishTurnRound:
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
        break;
      case GameCommands.finishRound:
        int roundWinner = data['data']['Winner'];
        changetimerValue(GameWaitTimes.rpcSleepRoundTime);
        player1RoundScore.value = 0;
        player2RoundScore.value = 0;
        currentRound.value += 1;
        currentTurnRound.value = 1;
        showFinishRoundDialog(roundWinner);
        if (roundWinner == 1) {
          player1TotalScore.value += 1;
        } else if (roundWinner == 2) {
          player2TotalScore.value += 1;
        }
        break;
      case GameCommands.finishGame:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        FunctionsLibraryClass.showSurrenderDialog(
          newData['Winner'],
          myGameId,
          GameTypes.rpc,
        );
        break;
      case GameCommands.surrender:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        FunctionsLibraryClass.showSurrenderDialog(
          newData['gamer_id'],
          myGameId,
          GameTypes.rpc,
        );
        break;
      default:
    }
  }

  void changetimerValue(int value) {
    Get.find<TimerCompanent>().startTimer(value);
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

  void getReconnectData(Map newData) {
    List gamers = newData['gamers'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    currentRound.value = gameData['current_round'];
    currentTurnRound.value = gameData['current_turn__round'];
    player1RoundScore.value = gameData['round_scores'][0];
    player2RoundScore.value = gameData['round_scores'][1];
    player1TotalScore.value = gameData['total_scores'][0];
    player2TotalScore.value = gameData['total_scores'][1];
    for (var gamerData in gamers) {
      players.add(Rx(PlayerModel.fromJson(gamerData)));
    }
    final int time =
        GameWaitTimes.tictactoeRoundTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  changePlayerReaction(int? playerId, int? reactionId, {int? removeTimer}) {
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.id == playerId) {
        if (showReactions.value) {
          players.value[i].value = players.value[i].value
              .changeReactionId(newReactionId: reactionId);
        }
        Future.delayed(Duration(seconds: removeTimer ?? 5)).then((_) {
          players.value[i].value = players.value[i].value.changeReactionId();
          letSendReaction.value = true;
        });
        break;
      }
    }
  }

  void sendCommand(Map data) {
    Get.find<GameSocketManager>().sendCommand(data);
  }

  void onEachButtonTap(RPCPeaceModel peace) {
    // if (!canSelectPeace.value) {
    //   print("not your turn");
    //   return;
    // }
    // canSelectPeace.value = false;
    // sendCommand({"id": GameCommands.selectPeace, "data": peace.peaceType.toString()});
    clearStatusFromPeaces(PeaceStatusTypes.selected);
    addPeaceStatus(peace.id, PeaceStatusTypes.selected);
    selectedPeace.value = peace.peaceType;
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
    // addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  }

  void acceptSelection() {
    sendCommand(
        {"id": GameCommands.selectPeace, "data": selectedPeace.value.name});
    peaceSelected.value = true;
  }

  void showReactionBox() {
    if (letSendReaction.value) {
      Get.bottomSheet(
        GlobalReactionsBox(
          onTap: () {
            letSendReaction.value = false;
          },
        ),
        backgroundColor: AppColors.lightColor,
      );
    }
  }

  bool isThisGamerIdThisTurnRoundWinner(int gamerId) {
    return gamerId == thisTurnRoundWinner.value;
  }

  void showFinishRoundDialog(int roundWinner) {
    if (roundWinner == 0) {
      DialogComponent().showIconicDialog(
        AppTexts.endRound.tr,
        AppTexts.roundDrawed.tr,
        GeneralIcons.drawRound,
        AppColors.drawColor,
      );
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.draw);
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      if (roundWinner == myGameId) {
        dialogMessage = AppTexts.youWinThisRound.tr;
        dialogIcon = GeneralIcons.happy;
        dialogColor = AppColors.winColor;
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
      } else {
        dialogMessage = AppTexts.youLoseThisRound.tr;
        dialogIcon = GeneralIcons.sad;
        dialogColor = AppColors.loseColor;
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
      }
      DialogComponent().showIconicDialog(
        'پایان دور',
        dialogMessage,
        dialogIcon,
        dialogColor,
      );
    }
  }

  void changeShowReactionStatus() {
    showReactions.value = !showReactions.value;
  }

  @override
  void onInit() async {
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
    );
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

    super.onInit();
  }
}
