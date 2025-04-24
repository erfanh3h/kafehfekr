import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_controller.dart';
import 'package:refreshed/refreshed.dart';

class SudokuBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<SudokuController>(
          () => SudokuController(),
          fenix: true,
        ),
      ];
}
