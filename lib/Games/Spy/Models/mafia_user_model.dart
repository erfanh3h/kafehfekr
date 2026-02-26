import 'package:refreshed/refreshed.dart';

class SpyUserModel {
  final RxString name = RxString("");
  final RxBool isSpy = RxBool(false);

  void changeUsername(String newName) {
    name.value = newName;
  }

  void changeisSpy() {
    isSpy.value = true;
  }
}
