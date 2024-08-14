import 'package:kafehfekr/Feature/FourInRow/Controllers/four_in_row_controller.dart';
import 'package:refreshed/refreshed.dart';

class FourInRowBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<FourInRowController>(
          () => FourInRowController(),
          fenix: true,
        ),
      ];
}
