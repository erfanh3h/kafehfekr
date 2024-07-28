import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_controller.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<MSweeperController>(
          () => MSweeperController(),
          fenix: true,
        ),
      ];
}
