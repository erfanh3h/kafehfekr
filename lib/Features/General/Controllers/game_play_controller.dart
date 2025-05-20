import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayController extends BaseController {
  RxList<QueuerModel> queuers = RxList([]);

  RxList<String> gameTypes = RxList([]);

  RxList<int> winners = RxList([]);

  String gameScoreType = '';

  RxInt currentGameIndex = RxInt(0);
  RxList<int> playerScores = RxList();

  RxBool isGameFinished = RxBool(false);
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
    queuers.clear();
    Map gameData = data['data'];
    gameScoreType = gameData['game_score_type'];
    for (var userDataJson in gameData['gamers']) {
      queuers.add(QueuerModel.fromJson(userDataJson));
    }
    gameTypes.value = List<String>.from(gameData['games']);
    winners.value = List<int>.from(gameData['winners']);
    currentGameIndex.value = gameData['current_game_index'];
    playerScores.value = List<int>.from(gameData['scores']);
    isGameFinished.value = gameData['is_game_finished'];
    isPageLoading.value = false;
    if (isGameFinished.value) {
      if (gameData['game_winner_id'] != null) {
        finishGameText.value = extractWinText(gameData['game_winner_id']);
      } else {
        //TODO : add this
      }
      Get.find<GlobalController>().finishGame();
      Get.find<GameSocketManager>().disconnect();
    }
  }

  void changeTimeFunction(data) async {
    Map gameData = data['data'];
    int time = gameData['time'];
    if (currentGameIndex.value == 0) {
      Get.find<TimerCompanent>().startTimer(5 - time + 1);
    } else {
      Get.find<TimerCompanent>().startTimer(20 - time + 1);
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

  extractWinText(String winnerId) {
    for (var gamer in queuers.value) {
      if (gamer.userId == winnerId) {
        return "${gamer.name} بازی رو برد";
      }
    }
    return "بازی مساوی به اتمام رسید";
  }

  String typeToImage() {
    if (gameScoreType == "Rank") {
      return GeneralIcons.rank;
    } else if (gameScoreType == "Lobby") {
      return GeneralIcons.lobby;
    } else {
      return GeneralIcons.multiRank;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isPageLoading.value = true;
    final myId = Get.find<GlobalController>().userId!;
    final gameId =
        Get.arguments ?? Get.find<GlobalController>().gameIdController.text;
    Get.find<SoundPlayerComponent>().startPlayMusic(isGame: true);
    Get.put(GameSocketManager());
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
      gameId: gameId,
      myId: myId,
    );
  }
}
