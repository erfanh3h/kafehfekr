import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Games/Mafia/Models/ciziten_roles.dart';
import 'package:kafehfekr/Games/Mafia/Models/indipendent_roles.dart';
import 'package:kafehfekr/Games/Mafia/Models/mafia_roles.dart';
import 'package:refreshed/refreshed.dart';

class MafiaOfflineController extends BaseOfflineGameController {
  int playersCount = 10;
  RxList<String> roles = RxList();

  RxBool isGamePhase = RxBool(false);

  RxInt showerCounter = RxInt(0);

  RxList<Map<String, String>> activeRoles = RxList();

  onAddNewRole(String role) {
    roles.add(role);
  }

  onRemoveRole(String role) {
    roles.remove(role);
  }

  changeSelectorIndex(int index) {
    if (index == 0) {
      activeRoles.value = citizenRoles;
    } else if (index == 1) {
      activeRoles.value = mafiaRoles;
    } else {
      activeRoles.value = independentRoles;
    }
  }

  @override
  resetGame() {
    roles.clear();
    isGamePhase.value = false;
    showerCounter.value = 0;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = OfflineGameTypes.Mafia;
    activeRoles.value = citizenRoles;
  }
}
