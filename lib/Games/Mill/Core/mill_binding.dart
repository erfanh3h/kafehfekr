import 'package:kafehfekr/Games/Mill/Controllers/mill_controller.dart';
import 'package:refreshed/refreshed.dart';

class MillBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<MillController>(
          () => MillController(),
          fenix: true,
        ),
      ];
}
