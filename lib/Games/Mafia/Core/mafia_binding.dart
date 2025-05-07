import 'package:kafehfekr/Games/Mafia/Controllers/mafia_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class MafiaBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<MafiaOfflineController>(
          () => MafiaOfflineController(),
          fenix: true,
        ),
      ];
}
