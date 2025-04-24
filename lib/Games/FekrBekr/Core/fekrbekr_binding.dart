import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_controller.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<FekrBekrController>(
          () => FekrBekrController(),
          fenix: true,
        ),
      ];
}
