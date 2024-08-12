import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:refreshed/refreshed.dart';

class YatzyBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<YatzyController>(
          () => YatzyController(),
          fenix: true,
        ),
      ];
}
