import 'package:flutter/widgets.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Network/multi_queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Models/message_model.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class MultiQueueController extends BaseController {
  RxBool isPreGameMode = RxBool(false);

  RxList<QueuerModel> queuers = RxList([]);
  late MultiGameTypes gameType;

  late String myId;

  RxList<MessageModel> messages = RxList();
  TextEditingController messageCtrl = TextEditingController();

  void onQueueStarted() {}

  void onQueueError() {
    stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void startQueue() {
    isPageLoading.value = true;
    Get.put(MultiQueueSocketManager());
    Get.find<MultiQueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      myId: myId,
      onQueueStart: onQueueStarted,
      onQueueError: onQueueError,
      gameType: gameType.name,
    );
    isPageLoading.value = false;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        startGameFunction(data);
      case GameCommands.message:
        final newMesaage = MessageModel(
          username: data['data']['name'],
          userId: data['data']['id'],
          content: data['data']['content'],
          time: DateTime.now(),
        );
        messages.insert(0, newMesaage);
        update();
      case GameCommands.logout:
        Get.find<GlobalController>().removeData().then((_) {
          Get.find<GlobalController>().checkLoginStatus();
        });
      default:
    }
  }

  void startGameFunction(dynamic data) {
    final String gameId = data['data']['game_id'];
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Get.offAndToNamed(AppRoutes.gamePlay, arguments: gameId);
      Get.find<GlobalController>().setActiveGameId(gameId);
      Get.find<SoundPlayerComponent>()
          .playGameSound(GameSoundTypes.queueFinded);
    });
  }

  void sendMessage() {
    if (messageCtrl.text.isEmpty) {
      return;
    }
    Get.find<MultiQueueSocketManager>()
        .sendCommand({'id': GameCommands.message, 'content': messageCtrl.text});
    messageCtrl.text = "";
  }

  void stopQueue() {
    Get.delete<MultiQueueSocketManager>();
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
    gameType = Get.arguments;
    myId = Get.find<GlobalController>().userId!;
    startQueue();
    super.onInit();
  }
}
