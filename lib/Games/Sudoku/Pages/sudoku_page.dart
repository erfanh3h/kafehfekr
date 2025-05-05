import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_controller.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_board_widget.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_select_number.dart';
import 'package:refreshed/refreshed.dart';

class SudokuPage extends BaseView<SudokuController> {
  const SudokuPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 15),
        if (controller.players.length > 1)
          GlobalGameDataWidget(
            player1Data: controller.players[0].value,
            player2Data: controller.players[1].value,
            timerColor: controller.returnTimerColor(),
            player1Number1: -1,
            player2Number1: -1,
          ),
        const SizedBox(height: 50),
        Expanded(
          child: ListView(
            children: [
              SudokuBoardWidget(controller: controller),
              SudokuSelectNumberBox(controller: controller),
              const SizedBox(height: 5),
              Center(
                child: GlobalButtonWidget(
                  onTap: controller.solveFunction,
                  text: AppTexts.accept.tr,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: GlobalActivityBox<SudokuController>(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
