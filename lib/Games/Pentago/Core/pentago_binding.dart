import 'package:kafehfekr/Games/Pentago/Controllers/pentago_controller.dart';
import 'package:refreshed/refreshed.dart';

class PentagoBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<PentagoController>(
          () => PentagoController(),
          fenix: true,
        ),
      ];
}
