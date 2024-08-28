import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/msweeper_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperController extends BaseGameController {
  RxList<Rx<MSweeperPeaceModel>> peaces = RxList();

  RxBool canSelectMine = RxBool(false);

  RxInt selectPeaceRemainingCount = RxInt(54);
  RxInt selectMineRemainingCount = RxInt(10);

  RxBool isBombHitted = RxBool(false);

  @override
  void commandHandler(dynamic data) {
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.mineSelected:
        mineSelectedFunction(data);
        break;
      case GameCommands.selectMineCorrect:
        selectMineCorrectFuntion(data);
        break;
      case GameCommands.selectMineWrong:
        selectMineWrongFunction(data);
        break;
      default:
    }
  }

  @override
  void startGameFunction(Map data) {
    canSelectPeace.value = true;
    canSelectMine.value = true;
    showInteraction(sound: GameSoundTypes.startGame);
    changetimerValue(GameWaitTimes.msweeperGameTime);
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  @override
  void selectPeaceResult(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['peace_number'];
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.changeValue(newValue: peaceData["value"]);
    addPeaceStatus(peaceId, PeaceStatusTypes.selected);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    selectPeaceRemainingCount.value -= 1;
    if (selectPeaceRemainingCount.value == 0) {
      canSelectPeace.value = false;
    }
  }

  @override
  void playerScoreFunction(Map data) {
    Map scoreData = data['data'];
    int score = scoreData['value'];
    int gamerId = scoreData['gamer_id'];
    if (gamerId == 1) {
      player1Score.value = score;
    } else {
      player2Score.value = score;
    }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    isBombHitted.value = gameData['is_tapped_mine'];
    selectPeaceRemainingCount.value = gameData["remaining_selectable_peaces"];
    selectMineRemainingCount.value = gameData["remaining_selectable_mines"];
    if (selectMineRemainingCount.value > 0) {
      canSelectMine.value = true;
    }
    if (selectPeaceRemainingCount.value > 0) {
      canSelectPeace.value = true;
    }
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = MSweeperPeaceModel.fromJson(boardData[i], i);
    }
    final int time = GameWaitTimes.msweeperGameTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    MSweeperPeaceModel peace = tappedPeace as MSweeperPeaceModel;
    if (isBombHitted.value) {
      showInteraction(text: AppTexts.bombExploded.tr);
      return;
    }
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    if (!canSelectMine.value) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    if (peace.value != null ||
        peace.sweeperStatuses.contains(
          MineSweeperStatusTypes.isMine,
        ) ||
        peace.sweeperStatuses.contains(
          MineSweeperStatusTypes.isWronglySelectedAsMine,
        )) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    showInteraction(sound: GameSoundTypes.tap);
  }

  void onEachButtonHold(MSweeperPeaceModel peace) {
    if (!canSelectMine.value) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    if (peace.value != null ||
        peace.currentStatuses.contains(PeaceStatusTypes.selected)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({"id": GameCommands.selectMine, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    showInteraction(sound: GameSoundTypes.tap);
  }

  void mineSelectedFunction(Map data) {
    showInteraction(sound: GameSoundTypes.explode);
    Map peaceData = data['data'];
    int peaceId = peaceData['peace_number'];
    addSweeperPeaceStatus(peaceId, MineSweeperStatusTypes.isExplodedMine);
    addSweeperPeaceStatus(peaceId, MineSweeperStatusTypes.isMine);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    selectPeaceRemainingCount.value = 0;
    selectMineRemainingCount.value = 0;
    canSelectPeace.value = false;
    canSelectMine.value = false;
    isBombHitted.value = true;
  }

  void selectMineCorrectFuntion(Map data) {
    showInteraction(sound: GameSoundTypes.correct);
    Map peaceData = data['data'];
    int peaceId = peaceData['peace_number'];
    addSweeperPeaceStatus(
        peaceId, MineSweeperStatusTypes.isCorrectlySelectedAsMine);
    addSweeperPeaceStatus(peaceId, MineSweeperStatusTypes.isMine);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    addPeaceStatus(peaceId, PeaceStatusTypes.selected);
    selectMineRemainingCount.value -= 1;
    if (selectMineRemainingCount.value == 0) {
      canSelectMine.value = false;
    }
  }

  void selectMineWrongFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['peace_number'];
    addSweeperPeaceStatus(
        peaceId, MineSweeperStatusTypes.isWronglySelectedAsMine);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    addPeaceStatus(peaceId, PeaceStatusTypes.selected);
    selectMineRemainingCount.value -= 1;
    if (selectMineRemainingCount.value == 0) {
      canSelectMine.value = false;
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  addSweeperPeaceStatus(int peaceId, MineSweeperStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addSweeperStatus(newStatus: status);
  }

  removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.id == peaceId) {
        peaces.value[i].value =
            peaces.value[i].value.removeStatus(status: status);
        break;
      }
    }
  }

  initPieces() {
    for (var i = 0; i < 64; i++) {
      peaces.add(
        Rx(
          MSweeperPeaceModel(
            id: i,
            currentStatuses: [],
            sweeperStatuses: [],
          ),
        ),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.MSweeper;
    initPieces();
  }
}
