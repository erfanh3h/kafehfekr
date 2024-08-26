import 'package:kafehfekr/Feature/General/Controllers/game_menu_controller.dart';
import 'package:refreshed/refreshed.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<GameMenuController>(() => GameMenuController(), fenix: true),
      ];
}
