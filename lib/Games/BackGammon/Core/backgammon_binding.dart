import 'package:kafehfekr/Games/BackGammon/Controllers/backgammon_controller.dart';
import 'package:refreshed/refreshed.dart';

class BackGammonBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<BackGammonController>(
          () => BackGammonController(),
          fenix: true,
        ),
      ];
}
