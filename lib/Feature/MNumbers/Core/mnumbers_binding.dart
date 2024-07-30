import 'package:kafehfekr/Feature/MNumbers/Controllers/mnumbers_controller.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<MNumbersController>(
          () => MNumbersController(),
          fenix: true,
        ),
      ];
}
