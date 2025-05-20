import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_chats_box.dart';
import 'package:kafehfekr/Core/Network/lobby_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Models/lobby_model.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/create_lobby_widget.dart';
import 'package:refreshed/refreshed.dart';

class LobbyController extends BaseController {
  RxList<LobbyModel> lobbies = RxList([]);

  GameTypes? selectedCreateGameType;

  TextEditingController lobbyNameController = TextEditingController();

  RxBool letSendChat = RxBool(true);

  RxList<(String, int)> joinedLobbyChats = RxList([]);

  RxBool imReadyToStart = RxBool(false);

  RxInt lobbyCount = RxInt(2);

  Rx<LobbyModel?> joinedLobby = Rx(null);
  RxList<Rx<QueuerModel>> joinedLobbyQueuers = RxList();

  resetLobbyData() {
    lobbyCount.value = 2;
    letSendChat.value = true;
    joinedLobbyChats.clear();
    lobbies.clear();
    imReadyToStart.value = false;
    joinedLobby.value = null;
    joinedLobbyQueuers.clear();
  }

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    final commandData = data['data'];

    switch (commandId) {
      case GameCommands.startGame:
        final String gameId = data['data']['game_id'];
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Get.offAndToNamed(AppRoutes.gamePlay, arguments: gameId);
          Get.find<GlobalController>().setActiveGameId(gameId);
          Get.find<SoundPlayerComponent>()
              .playGameSound(GameSoundTypes.queueFinded);
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
        isPageLoading.value = false;
        break;
      case GameCommands.lobbyData:
        joinedLobby.value = LobbyModel.fromJson(commandData);
        List<Rx<QueuerModel>> queuers = [];
        for (var element in commandData['queuers']) {
          queuers.add(Rx(QueuerModel.fromLobbyJson(element)));
        }
        joinedLobbyQueuers.value = queuers;
        break;
      case GameCommands.lobbyFull:
        DialogComponent().showToast(label: AppTexts.lobbyIsFull.tr);
        break;
      case GameCommands.lobbyPlayerReady:
        final userId = commandData['user_id'];
        int? userIndex = userIdToUserIndex(userId);
        if (userIndex != null) {
          joinedLobbyQueuers.value[userIndex].value =
              joinedLobbyQueuers.value[userIndex].value.copyWith(isRdy: true);
        }
        break;
      case GameCommands.lobbyNotExists:
        DialogComponent().showToast(label: AppTexts.lobbyDeleted.tr);
        final String lobbyId = commandData['lobby_id'];
        for (var lobby in lobbies) {
          if (lobby.lobbyId == lobbyId) {
            lobbies.remove(lobby);
            break;
          }
        }
        update();
        break;
      case GameCommands.lobbyDeleted:
        DialogComponent().showToast(label: AppTexts.lobbyDeleted.tr);
        resetLobbyData();
        break;
      case GameCommands.lobbyKick:
        DialogComponent().showToast(label: AppTexts.lobbyKicked.tr);
        resetLobbyData();
        for (var lobbyData in commandData) {
          lobbies.add(LobbyModel.fromJson(lobbyData));
        }
        break;
      default:
    }
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    final username = userIdToUsername(playerId);
    joinedLobbyChats.add((username, reactionId));
    Future.delayed(const Duration(seconds: 5)).then((_) {
      letSendChat.value = true;
    });
  }

  void onQueueError() {
    // stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void onCreateLobbyServer(int index) async {
    isPageLoading.value = true;
    final gameTypesParts = GameTypes.values.toList();
    selectedCreateGameType = gameTypesParts[index];
    sendCommand({
      "id": GameCommands.lobbyCreate,
      "data": {
        'lobby_name': lobbyNameController.text,
        'game_type': selectedCreateGameType!.name,
        'lobby_count': lobbyCount.value,
      }
    });
  }

  void onCreateLobby(int index) {
    if (lobbyNameController.text.isEmpty) {
      return;
    }
    if (index == -1) {
      return;
    }
    Get.closeAllBottomSheets();
    if (index == 18) {
      // in ludo we must get players count
      Get.dialog(
        Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.lightColor2,
            ),
            height: 150.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppTexts.usersCount.tr}: ",
                      style: const TextStyle(
                        color: AppColors.darkColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Obx(
                      () => DropdownButton<int>(
                        value: lobbyCount.value,
                        items: List.generate(3, (index) {
                          int number = index + 2;
                          return DropdownMenuItem(
                            value: number,
                            child: Text(
                              number.toString(),
                              style: const TextStyle(
                                color: AppColors.darkColor,
                                fontSize: 18,
                              ),
                            ),
                          );
                        }),
                        onChanged: (value) {
                          lobbyCount.value = value ?? 2;
                        },
                      ),
                    ),
                  ],
                ),
                GlobalButtonWidget(
                  onTap: () {
                    Get.closeAllDialogs();
                    onCreateLobbyServer(index);
                  },
                  text: AppTexts.start.tr,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      onCreateLobbyServer(index);
    }
  }

  void onJoinLobby(LobbyModel lobby) {
    if (lobby.queuersLength >= lobby.lobbyCount) {
      DialogComponent().showToast(label: AppTexts.lobbyIsFull.tr);
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
    if (isMyLobby()) {
      sendCommand({"id": GameCommands.lobbyDelete});
    } else {
      sendCommand({"id": GameCommands.lobbyQuit});
    }
    resetLobbyData();
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

  requestData() {
    lobbies.clear();
    sendCommand({"id": GameCommands.lobbyRequestData});
  }

  startGame() {
    for (var queuer in joinedLobbyQueuers.value) {
      if (!(queuer.value.isRdy ?? true)) {
        DialogComponent().showToast(label: AppTexts.allPlayersMustRdy.tr);
        return;
      }
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
    joinedLobbyQueuers.removeWhere((data) => data.value.userId == userId);
  }

  bool isMyLobby() {
    return Get.find<GlobalController>().userId == joinedLobby.value!.creatorId;
  }

  createLobby() {
    Get.bottomSheet(
      CreateLobbyWidget(
        lobbyNameController: lobbyNameController,
        onCreate: onCreateLobby,
      ),
      backgroundColor: AppColors.darkColor,
    );
  }

  String userIdToUsername(String userId) {
    for (var queuer in joinedLobbyQueuers.value) {
      if (queuer.value.userId == userId) {
        return queuer.value.name;
      }
    }
    return "";
  }

  int? userIdToUserIndex(String userId) {
    for (var index = 0; index < joinedLobbyQueuers.value.length; index++) {
      if (joinedLobbyQueuers.value[index].value.userId == userId) {
        return index;
      }
    }
    return null;
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
