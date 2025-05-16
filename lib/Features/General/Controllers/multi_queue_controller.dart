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
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class MultiQueueController extends BaseController {
  RxBool isPreGameMode = RxBool(false);

  RxList<QueuerModel> queuers = RxList([]);
  late MultiGameTypes gameType;

  late String myId;

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

  void sendCommand(Map data) {
    Get.find<MultiQueueSocketManager>().sendCommand(data);
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
