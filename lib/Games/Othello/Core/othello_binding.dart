import 'package:kafehfekr/Games/Othello/Controllers/othello_controller.dart';
import 'package:refreshed/refreshed.dart';

class OthelloBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<OthelloController>(
          () => OthelloController(),
          fenix: true,
        ),
      ];
}
