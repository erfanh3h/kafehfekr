import 'package:refreshed/refreshed.dart';

class MafiaUserModel {
  final RxString name = RxString("");
  final RxString role = RxString("");
  final RxBool isDead = RxBool(false);
  final RxBool showRole = RxBool(false);
  final Rx<bool?> isCitizen = Rx(null);

  void changeUsername(String newName) {
    name.value = newName;
  }

  void changeUserRole(String newRole) {
    role.value = newRole;
  }

  void changeIsDead() {
    isDead.value = !isDead.value;
  }

  void changeShowRole() {
    showRole.value = !showRole.value;
  }

  void changeIsCitizen(bool? newIsCitizen) {
    isCitizen.value = newIsCitizen;
  }
}
