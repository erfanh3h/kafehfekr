import 'package:kafehfekr/Games/DotBox/Controllers/dotbox_controller.dart';
import 'package:refreshed/refreshed.dart';

class DotBoxBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<DotBoxController>(
          () => DotBoxController(),
          fenix: true,
        ),
      ];
}
