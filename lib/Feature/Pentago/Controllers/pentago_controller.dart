import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Pentago/Models/pentago_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class PentagoController extends BaseGameController {
  RxList<Rx<PentagoPeaceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(18);
  RxInt player2Pawns = RxInt(18);

  RxBool isSelectionPlayed = RxBool(false);
  RxBool isRotationPlayed = RxBool(false);

  RxList<RxDouble> rotationValues =
      RxList([RxDouble(0), RxDouble(0), RxDouble(0), RxDouble(0)]);

  // rotate() {
  //   rotationValue.value = 0;
  //   Future.delayed(const Duration(milliseconds: 500)).then((_) {
  //     rotationValue.value -= 1 / 4;
  //     Future.delayed(const Duration(milliseconds: 1500)).then((_) {
  //       rotationValue.value = -1;
  //     });
  //   });
  // }

  @override
  void commandHandler(dynamic data) {
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.peaceRotated:
        onPeaceRotated(data);
        break;
      default:
    }
  }

  @override
  void currentTurnFunction(Map data) {
    isSelectionPlayed.value = false;
    isRotationPlayed.value = false;
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    if (turn == 1) {
      player1Pawns.value -= 1;
    } else {
      player2Pawns.value -= 1;
    }
    changetimerValue(GameWaitTimes.pentagoTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data'];
    final pieceId = selectionData['target_peace'];
    final int gamerId = selectionData['user'];
    removePeaceStatus(pieceId, PeaceStatusTypes.isLoading);
    changePeaceSelectedUser(pieceId, gamerId);
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    PentagoPeaceModel peace = tappedPeace as PentagoPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (isSelectionPlayed.value) {
      showInteraction(text: AppTexts.youSelectedBefore.tr);
      return;
    }
    if (peace.selectedUser != 0) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    isSelectionPlayed.value = true;
    final index = peace.id;
    sendCommand({"id": GameCommands.selectPeace, "data": index});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  }

  void onPeaceRotated(Map data) {
    Map rotationData = data['data'];
    List boardData = rotationData['board'];
    int index = rotationData['rotation_id'];
    int partIndex = (index / 2).ceil() - 1;
    rotationValues.value[partIndex].value = 0;
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      if (index % 2 == 0) {
        rotationValues.value[partIndex].value += 1 / 4;
      } else {
        rotationValues.value[partIndex].value -= 1 / 4;
      }
      Future.delayed(const Duration(milliseconds: 1200)).then((_) {
        for (var i = 0; i < boardData.length; i++) {
          changePeaceSelectedUser(i, boardData[i]);
        }
        rotationValues.value[partIndex].value = -1;
      });
    });
  }

  void onRotationTap(int index) {
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (!isSelectionPlayed.value) {
      showInteraction(text: AppTexts.selectPieceFirst.tr);
      return;
    }
    canSelectPeace.value = false;
    isRotationPlayed.value = true;
    sendCommand({"id": GameCommands.rotatePeace, "data": index});
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    player1Pawns.value = gameData['pawns'][0];
    player2Pawns.value = gameData['pawns'][1];
    isSelectionPlayed.value = gameData['selection_played'];
    isRotationPlayed.value = gameData['rotation_played'];
    for (var i = 0; i < boardData.length; i++) {
      changePeaceSelectedUser(i, boardData[i]);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.pentagoTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    }
  }

  changePeaceSelectedUser(int peaceId, int selectedUser) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changeSelectedUser(newSelectedUser: selectedUser);
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  initPeaces() {
    for (var i = 0; i < 36; i++) {
      peaces.add(
          Rx(PentagoPeaceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Pentago;
    initPeaces();
  }
}
