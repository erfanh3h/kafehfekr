import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Checkers/Models/checkers_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class CheckersController extends BaseGameController {
  RxList<Rx<CheckersPeaceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(0);
  RxInt player2Pawns = RxInt(0);

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
    changetimerValue(GameWaitTimes.checkersTurnTime);
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
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  changePeaceSelectedUser(int peaceId, int? selectedUser, {bool? isSuperPawn}) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changeSelectedUser(
            newSelectedUser: selectedUser, newIsSuperPawn: isSuperPawn);
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  initPeaces() {
    for (var i = 0; i < 64; i++) {
      peaces.add(Rx(CheckersPeaceModel(id: i, currentStatuses: [])));
    }
    changePeaceSelectedUser(0, 1);
    changePeaceSelectedUser(2, 1);
    changePeaceSelectedUser(4, 1);
    changePeaceSelectedUser(6, 1);
    changePeaceSelectedUser(9, 1);
    changePeaceSelectedUser(11, 1);
    changePeaceSelectedUser(13, 1);
    changePeaceSelectedUser(15, 1);
    changePeaceSelectedUser(16, 1);
    changePeaceSelectedUser(18, 1);
    changePeaceSelectedUser(20, 1);
    changePeaceSelectedUser(22, 1);
    changePeaceSelectedUser(41, 2);
    changePeaceSelectedUser(43, 2);
    changePeaceSelectedUser(45, 2);
    changePeaceSelectedUser(47, 2);
    changePeaceSelectedUser(48, 2);
    changePeaceSelectedUser(50, 2);
    changePeaceSelectedUser(52, 2);
    changePeaceSelectedUser(54, 2);
    changePeaceSelectedUser(57, 2);
    changePeaceSelectedUser(59, 2);
    changePeaceSelectedUser(61, 2);
    changePeaceSelectedUser(63, 2);
  }

  @override
  void onInit() async {
    gameType = GameTypes.tictactoe;
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
    );
    initPeaces();
    super.onInit();
  }
}
