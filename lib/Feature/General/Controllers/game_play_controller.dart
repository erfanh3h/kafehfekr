import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayController extends BaseController {
  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gamePlayData:
        gamePlayDataFunction(data);
        break;
      case GameCommands.navigateToGame:
        navigateToGameFunction(data);
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

  void gamePlayDataFunction(data) {}
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
