import 'package:kafehfekr/Games/MNumbers/Controllers/mnumbers_controller.dart';
import 'package:kafehfekr/Games/MNumbers/Controllers/mnumbers_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<MNumbersController>(
          () => MNumbersController(),
          fenix: true,
        ),
        Get.lazyPut<MNumbersOfflineController>(
          () => MNumbersOfflineController(),
          fenix: true,
        ),
      ];
}
