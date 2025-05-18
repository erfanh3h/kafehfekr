import 'package:flutter/widgets.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Network/chat_queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Models/message_model.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class ChatsController extends BaseController {
  RxBool isPreGameMode = RxBool(false);

  RxList<QueuerModel> queuers = RxList([]);

  late String myId;

  RxList<MessageModel> messages = RxList();
  TextEditingController messageCtrl = TextEditingController();

  RxInt usersCount = RxInt(0);

  void onQueueStarted() {}

  void onQueueError() {
    stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void startQueue() {
    isPageLoading.value = true;
    Get.put(ChatSocketManager());
    Get.find<ChatSocketManager>()
        .initSocket(commandHandler: commandHandler, myId: myId);
    isPageLoading.value = false;
  }

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.message:
        final newMesaage = MessageModel(
          username: data['data']['name'],
          userId: data['data']['id'],
          content: data['data']['content'],
          time: DateTime.now(),
        );
        messages.insert(0, newMesaage);
        update();
      case GameCommands.usersCount:
        print("here");
        usersCount.value = data['data'];
      default:
    }
  }

  void sendMessage() {
    if (messageCtrl.text.isEmpty) {
      return;
    }
    Get.find<ChatSocketManager>()
        .sendCommand({'id': GameCommands.message, 'content': messageCtrl.text});
    messageCtrl.text = "";
  }

  void stopQueue() {
    Get.delete<ChatSocketManager>();
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

  @override
  void onInit() {
    myId = Get.find<GlobalController>().userId!;
    startQueue();
    super.onInit();
  }
}
