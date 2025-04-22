import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/TicTacToe/Models/tictactoe_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToeOfflineController extends BaseOfflineGameController {
  RxList<Rx<TicTacToePeaceModel>> peaces = RxList();
  int maxRound = GameRoundCounts.tictactoeRoundCount;
  List<List<int>> winConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  void pieceSelectedFunction(int pieceId) {
    peaces[pieceId].value = peaces[pieceId]
        .value
        .changeSelectedUser(newSelectedUser: currentTurn.value);
    changeActiveTrun();
    isGameFinished.value = chackFinishRound();
  }

  void finishRoundFunction(Map data) {
    Map newData = data['data'];
    currentTurn.value = 0;
    int roundWinner = newData['Winner'] ?? 0;
    if (roundWinner == 1) {
      player1Score.value += 1;
    } else if (roundWinner == 2) {
      player2Score.value += 1;
    }
    // FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
  }

  void onEachButtonTap(dynamic tappedPeace) {
    if (isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    TicTacToePeaceModel piece = tappedPeace as TicTacToePeaceModel;
    if (piece.selectedUser != null) {
      showInteraction(text: AppTexts.selectedBefore.tr);
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    pieceSelectedFunction(piece.id);
  }

  bool chackFinishRound() {
    for (var winCondition in winConditions) {
      if (peaces[winCondition[0]].value.selectedUser == 1 &&
          peaces[winCondition[1]].value.selectedUser == 1 &&
          peaces[winCondition[2]].value.selectedUser == 1) {
        Future.delayed(const Duration(milliseconds: 350)).then((_) {
          showInteraction(sound: GameSoundTypes.win);
        });
        gameResultText.value = AppTexts.player1IsWinner.tr;
        DialogComponent().showToast(label: AppTexts.player1IsWinner.tr);
        return true;
      } else if (peaces[winCondition[0]].value.selectedUser == 2 &&
          peaces[winCondition[1]].value.selectedUser == 2 &&
          peaces[winCondition[2]].value.selectedUser == 2) {
        Future.delayed(const Duration(milliseconds: 350)).then((_) {
          showInteraction(sound: GameSoundTypes.win);
        });
        gameResultText.value = AppTexts.player2IsWinner.tr;
        DialogComponent().showToast(label: AppTexts.player2IsWinner.tr);
        return true;
      }
    }
    for (var peace in peaces) {
      if (peace.value.selectedUser == null) {
        return false;
      }
    }
    gameResultText.value = AppTexts.gameDrawed.tr;
    DialogComponent().showToast(label: "مساوی");
    Future.delayed(const Duration(milliseconds: 350)).then((_) {
      showInteraction(sound: GameSoundTypes.win);
    });
    return true;
  }

  void resetGame() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
    isGameFinished.value = false;
  }

  initPieces() {
    for (var i = 0; i < 9; i++) {
      peaces.add(Rx(TicTacToePeaceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    players.add(Rx(PlayerModel.fromOfflineGame(1)));
    players.add(Rx(PlayerModel.fromOfflineGame(2)));
    gameType = GameTypes.TicTacToe;
    initPieces();
  }
}
