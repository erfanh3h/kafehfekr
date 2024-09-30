import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
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
    isPageLoading.value = false;
  }

  void changeTimeFunction(data) {
    timerValue.value = 10;
    Future.delayed(const Duration(seconds: 10))
        .then((_) => timerValue.value = null);
    // Get.toNamed('/$gameType', arguments: gameId);
  }

  void navigateToGameFunction(data) {
    // Get.toNamed('/$gameType', arguments: gameId);
  }

  void deviceFinishGameFunction() {
    Get.find<GlobalController>().finishGame();
    Get.back();
    DialogComponent().showToast(label: AppTexts.gameFinished.tr);
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
