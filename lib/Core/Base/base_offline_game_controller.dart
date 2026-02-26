import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class BaseOfflineGameController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();

  RxInt currentRound = RxInt(1);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  RxInt currentTurn = RxInt(1);

  RxBool isGameStarted = RxBool(false);
  RxBool isGameFinished = RxBool(false);
  RxString gameResultText = RxString("");

  late OfflineGameTypes gameType;

  void changeActiveTrun() {
    if (currentTurn.value == 1) {
      currentTurn.value = 2;
    } else {
      currentTurn.value = 1;
    }
  }

  void showInteraction({String? text, GameSoundTypes? sound}) {
    Get.find<SoundPlayerComponent>()
        .playGameSound(sound ?? GameSoundTypes.tapWrong);
    if (text != null) {
      DialogComponent().showToast(label: text);
    }
  }

  void resetGame() {}
  void exitGame() {
    Get.back();
  }

  @override
  void onInit() {
    Get.find<SoundPlayerComponent>().stopMusic();
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    Get.find<SoundPlayerComponent>().startPlayMusic();
    super.onClose();
  }
}
