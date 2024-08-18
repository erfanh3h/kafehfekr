import 'package:kafehfekr/Feature/BoxFour/Controllers/boxfour_controller.dart';
import 'package:refreshed/refreshed.dart';

class BoxFourBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<BoxFourController>(
          () => BoxFourController(),
          fenix: true,
        ),
      ];
}
