import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_chats_box.dart';
import 'package:kafehfekr/Core/Network/lobby_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/General/Models/detailed_lobby_model.dart';
import 'package:kafehfekr/Feature/General/Models/lobby_model.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/create_lobby_widget.dart';
import 'package:refreshed/refreshed.dart';

class LobbyController extends BaseController {
  RxList<LobbyModel> lobbies = RxList([]);

  Rx<GameTypes?> selectedCreateGameType = Rx(null);
  Rx<DetailedLobbyModel?> joinedLobby = Rx(null);

  TextEditingController lobbyNameController = TextEditingController();

  RxBool letSendChat = RxBool(true);

  RxList<(bool, int)> joinedLobbyChats = RxList([]);

  RxBool imReadyToStart = RxBool(false);

  RxBool isPlayer1Rdy = RxBool(false);
  RxBool isPlayer2Rdy = RxBool(false);

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    final commandData = data['data'];

    switch (commandId) {
      case GameCommands.startGame:
        final String gameId = data['data']['game_id'];
        const String gameType = 'activeQueueType.value';
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Get.offAndToNamed(AppRoutes.gamePlay, arguments: gameId);
          Get.find<GlobalController>().setActiveGameId(gameId, gameType);
          Get.find<SoundPlayerComponent>()
              .playGameSound(GameSoundTypes.queueFinded);
          Get.find<SoundPlayerComponent>().startPlayMusic(isGame: true);
        });
        break;
      case GameCommands.lobbyList:
        isPageLoading.value = false;
        for (var lobbyData in commandData) {
          lobbies.add(LobbyModel.fromJson(lobbyData));
        }
        // gamePlayDataFunction(data);
        break;
      case GameCommands.yourLobbyCreated:
        break;
      case GameCommands.lobbyData:
        joinedLobby.value = DetailedLobbyModel.fromJson(commandData);
        break;
      case GameCommands.lobbyFull:
        DialogComponent().showToast(label: AppTexts.lobbyIsFull.tr);
        break;
      case GameCommands.lobbyPlayerReady:
        final userId = commandData['user_id'];
        if (userId == joinedLobby.value!.queuers[0].userId) {
          isPlayer1Rdy.value = true;
        } else {
          isPlayer2Rdy.value = true;
        }
        break;
      case GameCommands.lobbyDeleted:
        DialogComponent().showToast(label: AppTexts.lobbyDeleted.tr);
        Get.back();
        break;
      case GameCommands.lobbyKick:
        DialogComponent().showToast(label: AppTexts.lobbyKicked.tr);
        Get.back();
        break;
      default:
    }
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    bool isLeft = true;
    if (playerId == joinedLobby.value!.queuers[0].userId) {
      isLeft = false;
    }
    joinedLobbyChats.add((isLeft, reactionId));
    Future.delayed(const Duration(seconds: 5)).then((_) {
      letSendChat.value = true;
    });
  }

  void onQueueError() {
    // stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void onChangeGameType(GameTypes? gameType) {
    selectedCreateGameType.value = gameType;
  }

  void onCreateLobby() {
    if (lobbyNameController.text.isEmpty) {
      return;
    }
    if (selectedCreateGameType.value == null) {
      return;
    }
    sendCommand({
      "id": GameCommands.lobbyCreate,
      "data": {
        'lobby_name': lobbyNameController.text,
        'game_types': [selectedCreateGameType.value!.name],
      }
    });
    Get.closeAllBottomSheets();
  }

  void onJoinLobby(LobbyModel lobby) {
    if (lobby.queuersLength >= 2) {
      return;
    }
    sendCommand({
      "id": GameCommands.lobbyJoin,
      "data": {
        'lobby_id': lobby.lobbyId,
      }
    });
  }

  void sendCommand(Map data) {
    Get.find<LobbySocketManager>().sendCommand(data);
  }

  exitLobby() {
    Get.back();
  }

  void showChatBox() {
    if (letSendChat.value) {
      Get.bottomSheet(
        GlobalChatsBox(
          onTap: () {
            letSendChat.value = false;
          },
        ),
        backgroundColor: AppColors.darkColor,
      );
    }
  }

  startGame() {
    if (!isPlayer1Rdy.value || !isPlayer2Rdy.value) {
      DialogComponent().showToast(label: AppTexts.twoPlayersMustRdy.tr);
      return;
    }
    sendCommand({"id": GameCommands.lobbyStartGame});
    isPageLoading.value = true;
  }

  readyStartGame() {
    sendCommand({
      "id": GameCommands.lobbyPlayerReady,
    });
    imReadyToStart.value = true;
  }

  kickPlayer(String userId) {
    String myUserId = Get.find<GlobalController>().userId ?? "";
    if (userId == myUserId) {
      DialogComponent().showToast(label: AppTexts.cantKickYourself.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.lobbyKick,
      "data": {
        'user_id': userId,
      }
    });
    isPlayer2Rdy.value = false;
    joinedLobby.value = joinedLobby.value!.removeQueuer(userId);
  }

  bool isMyLobby() {
    return Get.find<GlobalController>().userId == joinedLobby.value!.creatorId;
  }

  createLobby() {
    Get.bottomSheet(
      Obx(
        () => CreateLobbyWidget(
          lobbyNameController: lobbyNameController,
          onCreate: onCreateLobby,
          onChangeGameType: onChangeGameType,
          selectedGameType: selectedCreateGameType.value,
        ),
      ),
      backgroundColor: AppColors.darkColor,
    );
  }

  @override
  void onInit() async {
    super.onInit();
    isPageLoading.value = true;
    Get.put(LobbySocketManager());
    Get.find<LobbySocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
      onQueueError: onQueueError,
    );
  }
}
