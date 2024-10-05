import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Network/lobby_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Models/lobby_model.dart';
import 'package:refreshed/refreshed.dart';

class LobbyController extends BaseController {
  RxList<LobbyModel> lobbies = RxList([]);

  RxBool isJoinedLobby = RxBool(false);

  Rx<GameTypes?> selectedCreateGameType = Rx(null);

  TextEditingController lobbyNameController = TextEditingController();
  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.lobbyList:
        isPageLoading.value = false;

        // gamePlayDataFunction(data);
        break;
      default:
    }
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    changePlayerReaction(playerId, reactionId);
  }

  changePlayerReaction(int gamerId, int reactionId, {int? removeTimer}) {
    // for (var i = 0; i < players.length; i++) {
    //   if (players[i].value.gamerId == gamerId) {
    //     if ((reactionId <= 100 && showStickers.value) ||
    //         (reactionId > 100 && showKoris.value)) {
    //       players.value[i].value = players.value[i].value
    //           .changeReactionId(newReactionId: reactionId);
    //       showInteraction(sound: GameSoundTypes.chat);
    //     }
    //     Future.delayed(Duration(seconds: removeTimer ?? 5)).then((_) {
    //       players.value[i].value = players.value[i].value.changeReactionId();
    //       if (reactionId <= 100) {
    //         letSendSticker.value = true;
    //       } else {
    //         letSendKori.value = true;
    //       }
    //     });
    //     break;
    //   }
    // }
  }

  void onQueueError() {
    // stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void onChangeGameType(GameTypes? gameType) {
    selectedCreateGameType.value = gameType;
  }

  void onCreateLobby() {}

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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
