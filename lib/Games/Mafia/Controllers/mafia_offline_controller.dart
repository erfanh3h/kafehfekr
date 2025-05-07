import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Games/Mafia/Models/ciziten_roles.dart';
import 'package:kafehfekr/Games/Mafia/Models/indipendent_roles.dart';
import 'package:kafehfekr/Games/Mafia/Models/mafia_roles.dart';
import 'package:kafehfekr/Games/Mafia/Models/mafia_user_model.dart';
import 'package:refreshed/refreshed.dart';

class MafiaOfflineController extends BaseOfflineGameController {
  int playersCount = 10;
  RxList<String> roles = RxList();

  RxBool isGamePhase = RxBool(false);

  RxInt showerCounter = RxInt(0);
  RxBool showRole = RxBool(false);

  RxList<Map<String, String>> activeRoles = RxList();

  RxList<MafiaUserModel> users = RxList([]);

  onAddNewRole(String role) {
    if (roles.length == playersCount) {
      showInteraction(sound: GameSoundTypes.tapWrong);
      return;
    }
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

  startGame() {
    if (roles.length != playersCount) {
      showInteraction(text: AppTexts.fillAllRoles.tr);
      return;
    }
    roles.shuffle();
    for (var i = 1; i <= playersCount; i++) {
      MafiaUserModel newUser = MafiaUserModel();
      newUser.changeUsername('بازیکن $i');
      newUser.changeUserRole(roles[i - 1]);
      users.add(newUser);
    }
    Get.toNamed(AppRoutes.mafiaRolesOffline)!.then((_) {
      isGamePhase.value = true;
    });
  }

  onNextShower() {
    if (showerCounter.value == playersCount - 1) {
      Get.back();
      return;
    }
    showRole.value = false;
    showerCounter += 1;
  }

  onChangeShowRole() {
    showRole.value = !showRole.value;
  }

  @override
  resetGame() {
    roles.clear();
    users.clear();
    isGamePhase.value = false;
    showerCounter.value = 0;
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      playersCount = Get.arguments;
    }
    gameType = OfflineGameTypes.Mafia;
    activeRoles.value = citizenRoles;
  }
}
