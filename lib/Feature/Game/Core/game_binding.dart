import 'package:kafehfekr/Feature/Game/Controllers/game_board_controller.dart';
import 'package:kafehfekr/Feature/Game/Core/game_repository.dart';
import 'package:refreshed/refreshed.dart';

class GameBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<GameRepository>(
          () => GameRepositoryImp(),
          fenix: true,
        ),
        Get.lazyPut<GameBoardController>(
          () => GameBoardController(
            Get.find<GameRepository>(),
          ),
          fenix: true,
        ),
      ];
}
