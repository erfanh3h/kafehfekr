import 'package:refreshed/refreshed.dart';

class SpyUserModel {
  final RxString name = RxString("");
  final RxBool isSpy = RxBool(false);

  changeUsername(String newName) {
    name.value = newName;
  }

  changeisSpy() {
    isSpy.value = true;
  }
}
