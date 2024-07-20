import 'package:kafehfekr/Feature/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:refreshed/refreshed.dart';

class GameBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<TicTacToeController>(
          () => TicTacToeController(),
          fenix: true,
        ),
      ];
}
