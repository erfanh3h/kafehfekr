import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/MNumbers/Models/mnumbers_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersOfflineController extends BaseOfflineGameController {
  RxList<Rx<MNumbersPeaceModel>> peaces = RxList();

  RxInt boardSize = RxInt(4);

  RxInt equippedPeaceIndex = RxInt(-1);
  RxInt tappedTimes = RxInt(0);
  RxInt matchHapppens = RxInt(0);

  RxBool lockSelect = RxBool(false);

  void pieceSelectFunction(int pieceId) {
    addPeaceStatus(pieceId, PeaceStatusTypes.equiped);
    if (equippedPeaceIndex.value == -1) {
      equippedPeaceIndex.value = pieceId;
    } else {
      lockSelect.value = true;
      tappedTimes.value += 1;
      if (peaces[equippedPeaceIndex.value].value.value ==
          peaces[pieceId].value.value) {
        matchHapppens.value += 1;
        addPeaceStatus(pieceId, PeaceStatusTypes.selected);
        addPeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.selected);
        equippedPeaceIndex.value = -1;
        Future.delayed(const Duration(milliseconds: 150)).then((_) {
          showInteraction(sound: GameSoundTypes.correct);
        });
        if (matchHapppens.value == (boardSize.value * 2)) {
          isGameFinished.value = true;
          Future.delayed(const Duration(milliseconds: 150)).then((_) {
            showInteraction(sound: GameSoundTypes.win);
            DialogComponent().showToast(label: AppTexts.gameFinished.tr);
          });
          return;
        }
        lockSelect.value = false;
      } else {
        Future.delayed(const Duration(seconds: 1)).then((_) {
          lockSelect.value = false;
          removePeaceStatus(pieceId, PeaceStatusTypes.equiped);
          removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
          equippedPeaceIndex.value = -1;
        });
      }
    }
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
    MNumbersPeaceModel piece = tappedPeace as MNumbersPeaceModel;
    if (isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    if (lockSelect.value) {
      return;
    }
    if (piece.currentStatuses.contains(PeaceStatusTypes.selected) ||
        piece.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    pieceSelectFunction(piece.id);
  }

  @override
  void resetGame() {
    peaces.clear();
    isGameFinished.value = false;
    equippedPeaceIndex.value = -1;
    lockSelect.value = false;
    tappedTimes.value = 0;
    matchHapppens.value = 0;
    initPieces();
  }

  void addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  void removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  void initPieces() {
    final numbersCount = (boardSize.value * boardSize.value / 2).toInt();
    List<int> numbers = [];
    for (var i = 1; i <= numbersCount; i++) {
      numbers.add(i);
      numbers.add(i);
    }
    numbers.shuffle();
    for (var i = 0; i < numbers.length; i++) {
      peaces.add(Rx(
          MNumbersPeaceModel(id: i, currentStatuses: [], value: numbers[i])));
    }
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      boardSize.value = Get.arguments;
    }
    super.onInit();
    gameType = OfflineGameTypes.MSweeper;
    initPieces();
  }
}
