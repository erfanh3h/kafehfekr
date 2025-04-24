import 'package:kafehfekr/Games/Yinsh/Controllers/yinsh_controller.dart';
import 'package:refreshed/refreshed.dart';

class YinshBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<YinshController>(
          () => YinshController(),
          fenix: true,
        ),
      ];
}
