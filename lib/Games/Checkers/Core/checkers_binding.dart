import 'package:kafehfekr/Games/Checkers/Controllers/checkers_controller.dart';
import 'package:refreshed/refreshed.dart';

class CheckersBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<CheckersController>(
          () => CheckersController(),
          fenix: true,
        ),
      ];
}
