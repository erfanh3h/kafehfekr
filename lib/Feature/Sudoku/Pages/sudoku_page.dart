import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Sudoku/Controllers/sudoku_controller.dart';
import 'package:kafehfekr/Feature/Sudoku/Widgets/sudoku_board_widget.dart';
import 'package:kafehfekr/Feature/Sudoku/Widgets/sudoku_select_number.dart';
import 'package:refreshed/refreshed.dart';

class SudokuPage extends BaseView<SudokuController> {
  const SudokuPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
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
          const Spacer(flex: 3),
          SudokuBoardWidget(controller: controller),
          SudokuSelectNumberBox(controller: controller),
          const Spacer(flex: 1),
          Center(
            child: GlobalButtonWidget(
              onTap: controller.solveFunction,
              text: AppTexts.accept.tr,
            ),
          ),
          const Spacer(flex: 4),
          Center(
            child: GlobalActivityBox<SudokuController>(),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
