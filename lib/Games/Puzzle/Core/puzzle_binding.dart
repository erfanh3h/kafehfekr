import 'package:kafehfekr/Games/Puzzle/Controllers/puzzle_offline_controller.dart';
import 'package:refreshed/refreshed.dart';

class PuzzleBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<PuzzleOfflineController>(
          () => PuzzleOfflineController(),
          fenix: true,
        ),
      ];
}
