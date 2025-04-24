import 'dart:math';

import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Games/MSweeper/Models/msweeper_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperOfflineController extends BaseOfflineGameController {
  RxList<Rx<MSweeperPeaceModel>> peaces = RxList();

  RxInt minesCount = RxInt(10);
  RxInt defusedPieces = RxInt(0);
  RxInt boardSize = RxInt(8);
  RxInt allPiecesCount = RxInt(0);

  RxBool isBombHitted = RxBool(false);

  void pieceSelectFunction(int pieceId) {
    if (isPieceMine(pieceId)) {
      isBombHitted.value = true;
      peaces[pieceId].value = peaces[pieceId]
          .value
          .addSweeperStatus(newStatus: MineSweeperStatusTypes.isExplodedMine);
      isGameFinished.value = true;
      Future.delayed(const Duration(milliseconds: 350)).then((_) {
        showInteraction(sound: GameSoundTypes.explode);
      });
      gameResultText.value = AppTexts.youLoseGame.tr;
      return;
    }
    peaces[pieceId].value =
        peaces[pieceId].value.addStatus(status: PeaceStatusTypes.selected);
    defusedPieces.value += 1;
    clearSafePieces(pieceId);
    isGameFinished.value =
        (allPiecesCount.value - defusedPieces.value == minesCount.value);
    if (isGameFinished.value) {
      gameResultText.value = AppTexts.youWinGame.tr;
    }
  }

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

  void onEachButtonTap(dynamic tappedPeace) {
    MSweeperPeaceModel piece = tappedPeace as MSweeperPeaceModel;
    if (isBombHitted.value || isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    if (piece.currentStatuses.contains(PeaceStatusTypes.selected) ||
        piece.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    pieceSelectFunction(piece.id);
  }

  void onEachButtonHold(MSweeperPeaceModel piece) {
    if (isBombHitted.value || isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    if (piece.currentStatuses.contains(PeaceStatusTypes.selected)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    if (piece.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      peaces[piece.id].value =
          peaces[piece.id].value.removeStatus(status: PeaceStatusTypes.equiped);
    } else {
      peaces[piece.id].value =
          peaces[piece.id].value.addStatus(status: PeaceStatusTypes.equiped);
    }
  }

  void resetGame() {
    peaces.clear();
    isGameFinished.value = false;
    isBombHitted.value = false;
    defusedPieces.value = 0;
    allPiecesCount.value = 0;
    initPieces();
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

  (int, int) indexToCoordinate(int index) {
    final x = index % boardSize.value;
    final y = index ~/ boardSize.value;
    return (x, y);
  }

  int coordinateToIndex((int, int) position) {
    final index = position.$2 * boardSize.value + position.$1;
    return index;
  }

  changePieceValue(int index, int value) {
    peaces[index].value = peaces[index].value.changeValue(newValue: value);
  }

  addValueToPiece(int index, {int value = 1}) {
    peaces[index].value.value = (peaces[index].value.value ?? 0) + value;
  }

  changePieceStatus(int index, MineSweeperStatusTypes status) {
    peaces[index].value =
        peaces[index].value.addSweeperStatus(newStatus: status);
  }

  bool isPieceMine(int index) {
    return peaces[index]
        .value
        .sweeperStatuses
        .contains(MineSweeperStatusTypes.isMine);
  }

  clearSafePieces(int index) {
    if (peaces[index].value.value != null) {
      return;
    }
    setPieceAsEmpty(index) {
      changePieceValue(index, 0);
      peaces[index].value =
          peaces[index].value.addStatus(status: PeaceStatusTypes.selected);
      defusedPieces.value += 1;
    }

    setPieceAsEmpty(index);
    (int, int) coordinate = indexToCoordinate(index);
    for (var i = coordinate.$1 - 1; i < coordinate.$1 + 2; i++) {
      if (0 <= i && i < boardSize.value) {
        int checkingIndex = coordinateToIndex((i, coordinate.$2 - 1));
        if (coordinate.$2 - 1 >= 0 &&
            peaces[checkingIndex].value.value == null) {
          setPieceAsEmpty(checkingIndex);
        }
        checkingIndex = coordinateToIndex((i, coordinate.$2 + 1));

        if (coordinate.$2 + 1 < boardSize.value &&
            peaces[checkingIndex].value.value == null) {
          setPieceAsEmpty(checkingIndex);
        }
      }
    }
    int checkingIndex = coordinateToIndex((coordinate.$1 - 1, coordinate.$2));
    if (coordinate.$1 - 1 >= 0 && peaces[checkingIndex].value.value == null) {
      setPieceAsEmpty(checkingIndex);
    }
    checkingIndex = coordinateToIndex((coordinate.$1 + 1, coordinate.$2));
    if (coordinate.$1 + 1 < boardSize.value &&
        peaces[checkingIndex].value.value == null) {
      setPieceAsEmpty(checkingIndex);
    }
  }

  addMines() {
    int mineIndex = 0;
    while (mineIndex < minesCount.value) {
      final rng = Random();
      final randomIndex = rng.nextInt(allPiecesCount.value);
      if (isPieceMine(randomIndex)) {
        continue;
      }
      print(randomIndex);
      changePieceStatus(randomIndex, MineSweeperStatusTypes.isMine);
      (int, int) coordinate = indexToCoordinate(randomIndex);
      for (var i = coordinate.$1 - 1; i < coordinate.$1 + 2; i++) {
        if (0 <= i && i < boardSize.value) {
          int checkingIndex = coordinateToIndex((i, coordinate.$2 - 1));
          if (coordinate.$2 - 1 >= 0 && !(isPieceMine(checkingIndex))) {
            addValueToPiece(checkingIndex);
          }
          checkingIndex = coordinateToIndex((i, coordinate.$2 + 1));

          if (coordinate.$2 + 1 < boardSize.value &&
              !(isPieceMine(checkingIndex))) {
            addValueToPiece(checkingIndex);
          }
        }
      }
      int checkingIndex = coordinateToIndex((coordinate.$1 - 1, coordinate.$2));
      if (coordinate.$1 - 1 >= 0 && !(isPieceMine(checkingIndex))) {
        addValueToPiece(checkingIndex);
      }
      checkingIndex = coordinateToIndex((coordinate.$1 + 1, coordinate.$2));
      if (coordinate.$1 + 1 < boardSize.value &&
          !(isPieceMine(checkingIndex))) {
        addValueToPiece(checkingIndex);
      }
      mineIndex++;
    }
  }

  initPieces() {
    allPiecesCount.value = boardSize.value * boardSize.value;
    for (var i = 0; i < allPiecesCount.value; i++) {
      peaces.add(
        Rx(
          MSweeperPeaceModel(id: i, currentStatuses: [], sweeperStatuses: []),
        ),
      );
    }
    addMines();
  }

  @override
  void onInit() async {
    final List<int>? args = Get.arguments;
    if (args != null) {
      boardSize.value = args[0];
      minesCount.value = args[1];
    }
    super.onInit();
    gameType = GameTypes.MSweeper;
    initPieces();
  }
}
