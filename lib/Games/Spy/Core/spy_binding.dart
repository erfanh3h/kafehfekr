import 'package:kafehfekr/Games/Spy/Controllers/spy_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class SpyBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<SpyOfflineController>(
          () => SpyOfflineController(),
          fenix: true,
        ),
      ];
}
