import 'package:refreshed/refreshed.dart';

class MafiaUserModel {
  final RxString name = RxString("");
  final RxString role = RxString("");
  final RxBool isDead = RxBool(false);
  final RxBool showRole = RxBool(false);

  changeUsername(String newName) {
    name.value = newName;
  }

  changeUserRole(String newRole) {
    role.value = newRole;
  }

  changeIsDead() {
    isDead.value = !isDead.value;
  }

  changeShowRole() {
    showRole.value = !showRole.value;
  }
}
