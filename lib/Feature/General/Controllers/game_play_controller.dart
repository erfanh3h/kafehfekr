import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayController extends BaseController {
  RxList<QueuerModel> queuers = RxList([]);

  RxList<String> gameTypes = RxList([]);

  RxList<int> winners = RxList([]);

  String gameScoreType = '';

  RxInt currentGameIndex = RxInt(0);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  Rx<int?> timerValue = Rx(null);

  RxBool isGameFinished = RxBool(false);
  RxInt winnerId = RxInt(-1);
  RxString finishGameText = RxString("");

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gamePlayData:
        gamePlayDataFunction(data);
        break;
      case GameCommands.gamePlayNavigate:
        navigateToGameFunction(data);
        break;
      case GameCommands.gamePlayTime:
        changeTimeFunction(data);
        break;
      case GameCommands.gameFinished:
        deviceFinishGameFunction();
        break;
      default:
    }
  }

  void reactionHandler(dynamic data) {
    // final playerId = data['playerId'];
    // final reactionId = data['reactionId'];
    // changePlayerReaction(playerId, reactionId);
  }

  void gamePlayDataFunction(data) {
    Map gameData = data['data'];
    gameScoreType = gameData['game_score_type'];
    for (var userDataJson in gameData['gamers']) {
      queuers.add(QueuerModel.fromJson(userDataJson));
    }
    gameTypes.value = List<String>.from(gameData['games']);
    winners.value = List<int>.from(gameData['winners']);
    currentGameIndex.value = gameData['current_game_index'];
    player1Score.value = gameData['gamer1_score'];
    player2Score.value = gameData['gamer2_score'];
    isGameFinished.value = gameData['is_game_finished'];
    isPageLoading.value = false;
    if (isGameFinished.value) {
      if (player1Score.value > player2Score.value) {
        winnerId.value = 1;
      } else if (player2Score.value > player1Score.value) {
        winnerId.value = 2;
      } else {
        winnerId.value = 0;
      }
      if (winnerId.value == 0) {
        finishGameText.value = "بازی مساوی به اتمام رسید";
      } else if (winnerId.value == 1) {
        finishGameText.value = "${queuers[0].name} بازی رو برد";
      } else if (winnerId.value == 2) {
        finishGameText.value = "${queuers[1].name} بازی رو برد";
      }
      Get.find<GlobalController>().finishGame();
      Get.find<GameSocketManager>().disconnect();
    }
  }

  void changeTimeFunction(data) async {
    Map gameData = data['data'];
    int time = gameData['time'];
    if (currentGameIndex.value == 0) {
      timerValue.value = 5 - time + 1;
      while (timerValue.value! > 0) {
        await Future.delayed(const Duration(seconds: 1));
        timerValue.value = timerValue.value! - 1;
      }
      timerValue.value = null;
    } else {
      timerValue.value = 20 - time + 1;
      while (timerValue.value! > 0) {
        await Future.delayed(const Duration(seconds: 1));
        timerValue.value = timerValue.value! - 1;
      }
      timerValue.value = null;
    }
  }

  void navigateToGameFunction(data) {
    Map gameData = data['data'];
    String gameType = gameTypes[gameData['current_game_index']];
    if (Get.currentRoute != AppRoutes.gamePlay) {
      Get.back();
    }
    Get.toNamed('/$gameType');
  }

  void deviceFinishGameFunction() {
    Get.find<GlobalController>().finishGame();
    Get.back();
    if (Get.currentRoute != AppRoutes.main) {
      Get.back();
    }
    DialogComponent().showToast(label: AppTexts.gameFinished.tr);
    Get.find<SoundPlayerComponent>().startPlayMusic(isGame: false);
  }

  @override
  void onInit() async {
    super.onInit();
    isPageLoading.value = true;
    final myId = Get.find<GlobalController>().userId!;
    final gameId =
        Get.arguments ?? Get.find<GlobalController>().gameIdController.text;
    Get.put(GameSocketManager());
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
      gameId: gameId,
      myId: myId,
    );
  }
}
