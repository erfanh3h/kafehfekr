import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Network/queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class QueueController extends BaseController {
  RxBool isPreGameMode = RxBool(false);

  RxList<QueuerModel> queuers = RxList([]);
  RxList<GameTypes> systemBannedGames = RxList();
  Rx<GameTypes?> systemSelectedGame = Rx(null);
  RxList<GameTypes> gamer1BannedGames = RxList();
  RxList<GameTypes> gamer2BannedGames = RxList();
  Rx<GameTypes?> player1SelectedGame = Rx(null);
  Rx<GameTypes?> player2SelectedGame = Rx(null);

  RxList<GameTypes> allGames = RxList();

  RxInt selectedGameIndex = RxInt(-1);
  RxInt activeIndex = RxInt(0);

  late String myId;
  String? preGameId;

  RxBool letSelectGame = RxBool(false);
  void onQueueStarted() {}

  void onQueueError() {
    stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void startQueue() {
    isPageLoading.value = true;
    for (var element in GameTypes.values) {
      allGames.add(element);
    }
    final userId = Get.find<GlobalController>().userId ?? "";
    Get.put(QueueSocketManager());
    Get.find<QueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      myId: userId,
      onQueueStart: onQueueStarted,
      onQueueError: onQueueError,
      preGameId: preGameId,
    );
    if (preGameId == null) {
      isPageLoading.value = false;
    }
    // activeQueueType.value = gameType;
    // activeQueueScoreType.value = gameScoreType;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        startGameFunction(data);
      case GameCommands.reconnectData:
        reconnectDataFunction(data);
      case GameCommands.startPreGame:
        startPreGameFunction(data);
      case GameCommands.systemBannedGames:
        systemBannedGamesFunction(data);
      case GameCommands.selectedGame:
        selectedGameFunction(data);
      case GameCommands.notEnoughCoin:
        DialogComponent().showToast(label: AppTexts.notEnoughCoin.tr);
        stopQueue();
      case GameCommands.gameFinished:
        Get.back();
        DialogComponent().showToast(label: AppTexts.gameFinished.tr);
      case GameCommands.selectGame:
        final targetId = data['data'];
        if (targetId == myId) {
          showInteraction(sound: GameSoundTypes.startTurn);
          letSelectGame.value = true;
        }
      default:
    }
  }

  void startGameFunction(dynamic data) {
    final String gameId = data['data']['game_id'];
    Get.find<GlobalController>().setActiveGameId(gameId);
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.queueFinded);
    Get.offNamed(AppRoutes.gamePlay, arguments: gameId);
    Future.delayed(const Duration(seconds: 1)).then((_) {
      // Get.toNamed('/$gameType', arguments: gameId);
      stopQueue();
    });
  }

  void reconnectDataFunction(dynamic data) {
    final Map reconnectData = data['data'];
    activeIndex.value = reconnectData['active_index'];
    if (reconnectData['system_selected_game'] != null) {
      systemSelectedGame.value =
          stringToGameType(reconnectData['system_selected_game']);
    }
    List<String> newData = List<String>.from(reconnectData['pre_bans']);
    for (var rawData in newData) {
      final gameValue = stringToGameType(rawData);
      allGames.remove(gameValue);
      systemBannedGames.add(gameValue);
    }

    final activeUserId = reconnectData['active_user_id'];
    if (activeUserId == myId) {
      showInteraction(sound: GameSoundTypes.startTurn);
      letSelectGame.value = true;
    }
    List queuersData = reconnectData['queuers'];
    if (queuersData.length != 2) {
      Get.back();
      return;
    }
    queuers.add(QueuerModel.fromJson(queuersData[0]));
    queuers.add(QueuerModel.fromJson(queuersData[1]));
    for (var bannedGame in queuersData[0]['banned_games']) {
      final gameType = stringToGameType(bannedGame);
      gamer1BannedGames.add(gameType);
      allGames.remove(gameType);
    }
    for (var bannedGame in queuersData[1]['banned_games']) {
      final gameType = stringToGameType(bannedGame);
      gamer2BannedGames.add(gameType);
      allGames.remove(gameType);
    }
    if (queuersData[0]['selected_game'] != null) {
      final gameType = stringToGameType(queuersData[0]['selected_game']);
      player1SelectedGame.value = gameType;
      allGames.remove(gameType);
    }
    if (queuersData[1]['selected_game'] != null) {
      final gameType = stringToGameType(queuersData[1]['selected_game']);
      player2SelectedGame.value = gameType;
      allGames.remove(gameType);
    }
    isPreGameMode.value = true;
    isPageLoading.value = false;
  }

  startPreGameFunction(dynamic data) {
    Get.find<SoundPlayerComponent>().startPlayQueueMusic();
    showInteraction(sound: GameSoundTypes.startGame);
    List queuersData = data['data']['queuers'];
    for (var queuer in queuersData) {
      queuers.add(QueuerModel.fromJson(queuer));
    }
    DialogComponent().showTimerDialog(time: 5);
    isPreGameMode.value = true;
    preGameId = data['data']['id'];
  }

  void selectedGameFunction(dynamic data) {
    final gameType = data['data']['game_type'];
    activeIndex.value = data['data']['active_index'];
    switch (activeIndex.value) {
      case 1:
        gamer1BannedGames.add(stringToGameType(gameType));
      case 2:
        gamer2BannedGames.add(stringToGameType(gameType));
      case 3:
        player1SelectedGame.value = stringToGameType(gameType);
      case 4:
        player2SelectedGame.value = stringToGameType(gameType);
      case 5:
        gamer1BannedGames.add(stringToGameType(gameType));
      case 6:
        gamer2BannedGames.add(stringToGameType(gameType));
      case 7:
        systemSelectedGame.value = stringToGameType(gameType);
        DialogComponent().showTimerDialog(time: 5);
    }
    final gameValue = stringToGameType(gameType);
    allGames.remove(gameValue);
    update();
    activeIndex.value += 1;
  }

  systemBannedGamesFunction(dynamic data) {
    List<String> newData = List<String>.from(data['data']);
    for (var rawData in newData) {
      final gameValue = stringToGameType(rawData);
      allGames.remove(gameValue);
      systemBannedGames.add(gameValue);
    }
    activeIndex.value += 1;
  }

  void sendCommand(Map data) {
    Get.find<QueueSocketManager>().sendCommand(data);
  }

  sendSelection() {
    if (selectedGameIndex.value == -1) {
      DialogComponent().showToast(label: AppTexts.selectGameTypeFirst.tr);
      return;
    }
    letSelectGame.value = false;
    final selectedGameType = allGames[selectedGameIndex.value];
    selectedGameIndex.value = -1;
    sendCommand({
      'id': GameCommands.selectGame,
      'game_type': selectedGameType.name,
      'pre_game_id': preGameId,
    });
  }

  void stopQueue() {
    Get.delete<QueueSocketManager>();
  }

  void showInteraction({String? text, GameSoundTypes? sound}) {
    Get.find<SoundPlayerComponent>()
        .playGameSound(sound ?? GameSoundTypes.tapWrong);
    if (text != null) {
      DialogComponent().showToast(label: text);
    }
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  changeSelectedGame(int index) {
    if (selectedGameIndex.value == index) {
      selectedGameIndex.value = -1;
    } else {
      selectedGameIndex.value = index;
    }
  }

  @override
  void onInit() {
    preGameId = Get.arguments;
    startQueue();
    myId = Get.find<GlobalController>().userId!;
    super.onInit();
  }
}
