import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:kafehfekr/Games/Risk/Models/risk_user_model.dart';
import 'package:kafehfekr/Games/Risk/Widgets/risk_my_continents_detail.dart';
import 'package:refreshed/refreshed.dart';

class RiskController extends BaseGameController {
  RxList<Rx<RiskUserModel>> riskUsersData = RxList();
  Rx<RiskUserModel?> myData = Rx(null);

  int playersCount = 2;

  RxList<int> currentAvailableIndexes = RxList();
  RxList<int> activePlayerIndexes = RxList();

  RxBool canExitGame = RxBool(false);

  RxInt strategiesCount = RxInt(40);
  RxInt continentsCount = RxInt(42);
  RxInt tokensCount = RxInt(6);

  RxString gameLog = RxString("");
  RxList<ContinentTypes> drawedContinents = RxList([]);
  RxList<StrategyTypes> drawedStrategiess = RxList([]);

  Rx<RiskGameStates> gameState = Rx(RiskGameStates.StartGame);

  @override
  void commandHandler(dynamic data) {
    print(data);
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.drawCard:
        drawCardFunction(data);
        break;
      case GameCommands.userData:
        myData.value = RiskUserModel.fromPrivateJson(data['data']);
        break;
      case GameCommands.drawResult:
        drawResultFunction(data);
        break;
      case GameCommands.drawResultPrivate:
        drawResultPrivateFunction(data);
        break;
      case GameCommands.passTurn:
        break;
      default:
    }
  }

  @override
  void gameDataFunction(Map data) async {
    activePlayerIndexes.clear();
    Map gameData = data['data']['game_data'];
    applyGameData(gameData);
    for (var i = 0; i < players.length; i++) {
      activePlayerIndexes.value.add(i + 1);
    }
    super.gameDataFunction(data);
  }

  @override
  void finishGameFunction(Map data) {
    isGameFinished.value = true;
    canSelectPeace.value = false;
    Map newData = data['data'];
    int rank1 = newData['rank1'];
    int rank2 = newData['rank2'];
    stopTimer();
    FunctionsLibraryClass.showFinishMultiplayerGameDialog(
        rank1, rank2, myGameId, gameType);
  }

  void drawCardFunction(Map data) {
    int turn = data['data']['turn'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {}
    changetimerValue(GameWaitTimes.ludoTurnTime);
    gameState(RiskGameStates.Draw);
  }

  void drawResultFunction(Map data) {
    int userIndex = data['data']['gamer_id'];
    int drawType = data['data']['draw_type'];
    final String activeUsername = getActiveGamerUsername();
    riskUsersData[userIndex - 1].value =
        RiskUserModel.fromGlobalJson(data['data']['new_data']);
    if (drawType == 1) {
      gameLog.value = "$activeUsername \n ${AppTexts.twoContinent.tr} کشید";
    } else if (drawType == 2) {
      gameLog.value = "$activeUsername \n ${AppTexts.twoStrategy.tr} کشید";
    } else if (drawType == 3) {
      gameLog.value =
          "$activeUsername \n ${AppTexts.oneContinentOneStrategy.tr} کشید";
    }
    gameState(RiskGameStates.DrawResult);
  }

  void drawResultPrivateFunction(Map data) {
    int drawType = data['data']['draw_type'];
    List draws = data['data']['data'];
    myData.value = RiskUserModel.fromPrivateJson(data['data']['new_user_data']);
    switch (drawType) {
      case 1:
        for (var continent in draws) {
          final ContinentTypes continentName = ContinentTypes.values.firstWhere(
            (e) => e.name == continent,
          );
          drawedContinents.add(continentName);
        }
        break;
      case 2:
        for (var strategy in draws) {
          final StrategyTypes strategyName = StrategyTypes.values.firstWhere(
            (e) => e.name == strategy,
          );
          drawedStrategiess.add(strategyName);
        }
        break;
      case 3:
        final ContinentTypes continentName = ContinentTypes.values.firstWhere(
          (e) => e.name == draws[0],
        );
        drawedContinents.add(continentName);
        final StrategyTypes strategyName = StrategyTypes.values.firstWhere(
          (e) => e.name == draws[1],
        );
        drawedStrategiess.add(strategyName);
        break;
      case 4:
        final StrategyTypes strategyName = StrategyTypes.values.firstWhere(
          (e) => e.name == draws[1],
        );
        drawedStrategiess.add(strategyName);
        break;
      default:
    }
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map pieceData = data['data'];
    // int index = pieceData['index'];
    // int? targetIndex = pieceData['target_index'];
    // int gamerId = pieceData['gamer_id'];
    // String type = pieceData['type'];
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    applyGameData(gameData);
    // Map timerData = newData['timer_data'];
    // List boardData = gameData['board'];
    // List startBoardData = gameData['start_board'];
    // currentTurn.value = gameData['current_turn'];
    // currentDice.value = gameData['current_dice'];
    // currentTurnPlayerRolled.value = gameData['current_turn_player_rolled'];
    // activePlayerIndexes.value =
    //     List<int>.from(gameData['active_player_indexes']);
    // if (!activePlayerIndexes.contains(myGameId)) {
    //   canExitGame.value = true;
    // }
    // playersOutPieces.value = List<int>.from(gameData['players_out_pieces']);
    // for (var i = 0; i < boardData.length; i++) {
    //   if (boardData[i]['equipped_user'] == 0) {
    //     continue;
    //   }
    //   changePieceSelecteUser(i, boardData[i]['equipped_user'],
    //       count: boardData[i]['count']);
    // }
    // for (var i = 0; i < startBoardData.length; i++) {
    //   if (startBoardData[i]['equipped_user'] == 0) {
    //     continue;
    //   }
    //   changeStartPieceSelectedUser(i, startBoardData[i]['equipped_user'],
    //       count: startBoardData[i]['count']);
    // }
    // if (currentTurn.value == myGameId) {
    //   canSelectPeace.value = true;
    //   if (currentTurnPlayerRolled.value) {
    //     setAvailableMoves();
    //   }
    // } else {
    //   canSelectPeace.value = false;
    // }
    // if (timerData['is_user_turn']) {
    //   final int time = GameWaitTimes.ludoTurnTime - timerData['time'] as int;
    //   changetimerValue(time.clamp(0, time));
    // }
  }

  applyGameData(Map data) {
    currentTurn.value = data['current_turn'];
    activePlayerIndexes.value = List<int>.from(data['active_player_indexes']);
    strategiesCount.value = data['strategies'];
    continentsCount.value = data['continents'];
    for (var playerData in data['players_data']) {
      riskUsersData.add(Rx(RiskUserModel.fromGlobalJson(playerData)));
    }
    tokensCount.value = data['tokens'];
  }

  drawCard(int number) {
    gameState(RiskGameStates.Loading);
    sendCommand({
      'id': GameCommands.drawCard,
      'draw_type': number,
    });
  }

  surrenderByUserFunction() {
    DialogComponent().showIconicSelectionDialog(
      AppTexts.surrender.tr,
      AppTexts.wanaSurrenderGame.tr,
      GeneralIcons.death,
      AppColors.loseColor,
      () {
        Get.find<GameSocketManager>()
            .sendCommand({"id": GameCommands.surrender});
        Get.closeAllDialogs();
        canExitGame.value = true;
      },
      () {
        Get.closeAllDialogs();
      },
    );
  }

  openMyContinents() {
    if (myData.value == null) {
      return;
    }
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: RiskMyContinentsWidget(continents: myData.value!.continents),
      ),
    );
  }

  openMyStrategies() {
    if (myData.value == null) {
      return;
    }
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: RiskMyContinentsWidget(continents: myData.value!.continents),
      ),
    );
  }

  openMyTokens() {
    if (myData.value == null) {
      return;
    }
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: RiskMyContinentsWidget(continents: myData.value!.continents),
      ),
    );
  }

  exitGame() {
    sendCommand({"id": GameCommands.exitGame, "data": {}});
    Get.closeAllDialogs();
    Get.back();
    Get.back();
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Risk;
    isPageLoading.value = false;
  }
}
