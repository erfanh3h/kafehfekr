import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_chats_box.dart';
import 'package:kafehfekr/Core/Network/lobby_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Models/detailed_lobby_model.dart';
import 'package:kafehfekr/Feature/General/Models/lobby_model.dart';
import 'package:refreshed/refreshed.dart';

class LobbyController extends BaseController {
  RxList<LobbyModel> lobbies = RxList([]);

  Rx<GameTypes?> selectedCreateGameType = Rx(null);
  Rx<DetailedLobbyModel?> joinedLobby = Rx(null);

  TextEditingController lobbyNameController = TextEditingController();

  RxBool letSendKori = RxBool(true);

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    final commandData = data['data'];

    switch (commandId) {
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
        break;
      default:
    }
  }

  void reactionHandler(dynamic data) {
    // final playerId = data['playerId'];
    // final reactionId = data['reactionId'];
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
    if (letSendKori.value) {
      Get.bottomSheet(
        GlobalChatsBox(
          onTap: () {
            letSendKori.value = false;
          },
        ),
        backgroundColor: AppColors.darkColor,
      );
    }
  }

  startGame() {}

  readyStartGame() {}

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
