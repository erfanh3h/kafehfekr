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
import 'package:kafehfekr/Games/Risk/Models/risk_user_model.dart';
import 'package:refreshed/refreshed.dart';

class RiskController extends BaseGameController {
  RxList<Rx<RiskUserModel>> usersData = RxList();
  Rx<RiskUserModel?> myData = Rx(null);

  int playersCount = 2;

  RxList<int> currentAvailableIndexes = RxList();
  RxList<int> activePlayerIndexes = RxList();

  RxBool canExitGame = RxBool(false);

  RxInt strategiesCount = RxInt(40);
  RxInt continentsCount = RxInt(42);
  RxInt tokensCount = RxInt(6);

  @override
  void commandHandler(dynamic data) {
    print(data);
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.userData:
        myData.value = RiskUserModel.fromPrivateJson(data['data']);
        break;
      case GameCommands.drawCard:
        int userIndex = data['data']['gamer_index'];
        usersData[userIndex].value =
            RiskUserModel.fromPrivateJson(data['data']['new_data']);
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

  @override
  void currentTurnFunction(Map data) async {
    int turn = data['data']['turn'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.ludoTurnTime);
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
      usersData.add(Rx(RiskUserModel.fromGlobalJson(playerData)));
    }
    tokensCount.value = data['tokens'];
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
