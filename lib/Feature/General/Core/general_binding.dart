import 'package:kafehfekr/Feature/General/Controllers/maintence_controlle.dart';
import 'package:kafehfekr/Feature/General/Controllers/update_controller.dart';
import 'package:refreshed/refreshed.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<UpdateController>(
          () => UpdateController(),
          fenix: true,
        ),
        Get.lazyPut<MaintenceController>(
          () => MaintenceController(),
          fenix: true,
        ),
      ];
}
