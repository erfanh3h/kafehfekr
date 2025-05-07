import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class MafiaOfflineController extends BaseOfflineGameController {
  @override
  void onInit() async {
    super.onInit();
    gameType = OfflineGameTypes.Mafia;
  }
}
