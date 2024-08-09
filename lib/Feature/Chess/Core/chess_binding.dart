import 'package:kafehfekr/Feature/Chess/Controllers/chess_controller.dart';
import 'package:refreshed/refreshed.dart';

class ChessBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<ChessController>(
          () => ChessController(),
          fenix: true,
        ),
      ];
}
