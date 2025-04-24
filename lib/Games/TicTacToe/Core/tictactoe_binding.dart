import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class TicTactoeBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<TicTacToeController>(
          () => TicTacToeController(),
          fenix: true,
        ),
        Get.lazyPut<TicTacToeOfflineController>(
          () => TicTacToeOfflineController(),
          fenix: true,
        ),
      ];
}
