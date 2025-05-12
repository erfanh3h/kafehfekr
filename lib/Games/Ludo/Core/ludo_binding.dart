import 'package:kafehfekr/Games/Ludo/Controllers/ludo_controller.dart';
import 'package:refreshed/refreshed.dart';

class LudoBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<LudoController>(() => LudoController(), fenix: true),
      ];
}
