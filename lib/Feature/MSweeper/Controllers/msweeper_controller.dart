import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
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
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/msweeper_peace_model.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class MSweeperController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();
  RxList<Rx<MSweeperPeaceModel>> peaces = RxList();

  int myId = 1;
  int myGameId = 2;
  String gameId = "gameId";

  RxBool canSelectPeace = RxBool(false);
  RxBool canSelectMine = RxBool(false);

  RxBool showReactions = RxBool(true);

  RxBool letSendReaction = RxBool(true);

  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);

  RxInt selectPeaceRemainingCount = RxInt(54);
  RxInt selectMineRemainingCount = RxInt(10);

  RxBool isBombHitted = RxBool(false);

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
      case GameCommands.startGame:
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.startGame);
        canSelectPeace.value = true;
        canSelectMine.value = true;
        changetimerValue(GameWaitTimes.msweeperGameTime);
        break;
      case GameCommands.selectPeaceResult:
        Map peaceData = data['data'];
        int peaceId = peaceData['peace_number'];
        peaces.value[peaceId].value = peaces.value[peaceId].value
            .changeValue(newValue: peaceData["value"]);
        addPeaceStatus(peaceId, PeaceStatusTypes.selected);
        removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
        selectPeaceRemainingCount.value -= 1;
        if (selectPeaceRemainingCount.value == 0) {
          canSelectPeace.value = false;
        }
        break;
      case GameCommands.mineSelected:
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.explode);
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
        break;
      case GameCommands.selectMineCorrect:
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
        break;
      case GameCommands.selectMineWrong:
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
        break;
      case GameCommands.playerScore:
        Map scoreData = data['data'];
        int score = scoreData['value'];
        int gamerId = scoreData['gamer_id'];
        if (gamerId == 1) {
          player1Score.value = score;
        } else {
          player2Score.value = score;
        }
        break;
      case GameCommands.finishGame:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        showFinishGameDialog(newData);
        break;
      case GameCommands.surrender:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        showSurrenderDialog(newData);
        break;
      default:
    }
  }

  Color? returnTimerColor() {
    return AppColors.goldenColor;
  }

  void changetimerValue(int value) {
    Get.find<TimerCompanent>().startTimer(value);
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

  removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.id == peaceId) {
        peaces.value[i].value =
            peaces.value[i].value.removeStatus(status: status);
        break;
      }
    }
  }

  addSweeperPeaceStatus(int peaceId, MineSweeperStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addSweeperStatus(newStatus: status);
  }

  void getReconnectData(Map newData) {
    List gamers = newData['gamers'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    selectPeaceRemainingCount.value = gameData["remaining_selectable_peaces"];
    selectMineRemainingCount.value = gameData["remaining_selectable_mines"];
    if (selectMineRemainingCount.value > 0) {
      canSelectMine.value = true;
    }
    if (selectPeaceRemainingCount.value > 0) {
      canSelectPeace.value = true;
    }
    for (var gamerData in gamers) {
      players.add(Rx(PlayerModel.fromJson(gamerData)));
    }
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = MSweeperPeaceModel.fromJson(boardData[i], i);
    }
    final int time = GameWaitTimes.msweeperGameTime - timerData['time'] as int;
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

  void onEachButtonTap(MSweeperPeaceModel peace) {
    if (!canSelectPeace.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (!canSelectMine.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (peace.value != null ||
        peace.sweeperStatuses.contains(
          MineSweeperStatusTypes.isMine,
        ) ||
        peace.sweeperStatuses.contains(
          MineSweeperStatusTypes.isWronglySelectedAsMine,
        )) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
  }

  void onEachButtonHold(MSweeperPeaceModel peace) {
    if (!canSelectMine.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (peace.value != null ||
        peace.currentStatuses.contains(PeaceStatusTypes.selected)) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    sendCommand({"id": GameCommands.selectMine, "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
  }

  void surrenderFnction() {
    DialogComponent().showIconicSelectionDialog(
      AppTexts.surrender.tr,
      AppTexts.wanaSurrenderGame.tr,
      GeneralIcons.death,
      AppColors.loseColor,
      () {
        Get.find<GameSocketManager>()
            .sendCommand({"id": GameCommands.surrender});
        Get.closeAllDialogs();
      },
      () {
        Get.closeAllDialogs();
      },
    );
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

  void showFinishRoundDialog(int roundWinner) {
    if (roundWinner == 0) {
      DialogComponent().showIconicDialog(
        AppTexts.endRound.tr,
        AppTexts.roundDrawed.tr,
        GeneralIcons.drawRound,
        AppColors.drawColor,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      if (roundWinner == myGameId) {
        dialogMessage = AppTexts.youWinThisRound.tr;
        dialogIcon = GeneralIcons.happy;
        dialogColor = AppColors.winColor;
      } else {
        dialogMessage = AppTexts.youLoseThisRound.tr;
        dialogIcon = GeneralIcons.sad;
        dialogColor = AppColors.loseColor;
      }
      DialogComponent().showIconicDialog(
        'پایان دور',
        dialogMessage,
        dialogIcon,
        dialogColor,
      );
    }
  }

  void showFinishGameDialog(Map newData) {
    int gameWinner = newData['Winner'] ?? 0;
    if (gameWinner == 0) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.draw);
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        AppTexts.gameDrawed.tr,
        GeneralIcons.draw,
        AppColors.drawColor,
        coin: 0,
        cup: 0,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      int cup = 0;
      int coin = 0;
      if (gameWinner == myGameId) {
        dialogMessage = AppTexts.youWinGame.tr;
        dialogIcon = GeneralIcons.win;
        dialogColor = AppColors.winColor;
        cup = CupsCount.tictactoeWin;
        coin = CoinsCount.tictactoeWin;
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
      } else {
        dialogMessage = AppTexts.youLoseGame.tr;
        dialogIcon = GeneralIcons.lose;
        dialogColor = AppColors.loseColor;
        cup = CupsCount.tictactoeLose;
        coin = CoinsCount.tictactoeLose;
        Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
      }
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        dialogMessage,
        dialogIcon,
        dialogColor,
        coin: coin,
        cup: cup,
      );
    }
  }

  void showSurrenderDialog(Map newData) {
    int gamerId = newData['gamer_id'] ?? 1;
    String dialogMessage = "";
    String dialogIcon = "";
    Color dialogColor = Colors.white;
    int cup = 0;
    int coin = 0;
    if (gamerId == myGameId) {
      dialogMessage = AppTexts.youSurrenderGame.tr;
      dialogIcon = GeneralIcons.lose;
      dialogColor = AppColors.loseColor;
      cup = CupsCount.tictactoeLose;
      coin = CoinsCount.tictactoeLose;
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.lose);
    } else {
      dialogMessage = AppTexts.enemySurrenderGame.tr;
      dialogIcon = GeneralIcons.win;
      dialogColor = AppColors.winColor;
      cup = CupsCount.tictactoeWin;
      coin = CoinsCount.tictactoeWin;
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.win);
    }
    DialogComponent().showIconicDialog(
      AppTexts.endGame.tr,
      dialogMessage,
      dialogIcon,
      dialogColor,
      coin: coin,
      cup: cup,
    );
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
    super.onInit();
  }
}
