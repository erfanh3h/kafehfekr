import 'package:kafehfekr/Games/Ten/Controllers/ten_controller.dart';
import 'package:refreshed/refreshed.dart';

class TenBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<TenController>(
          () => TenController(),
          fenix: true,
        ),
      ];
}
