import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_offline_controller.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_offline_board_widget.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_offline_select_number.dart';
import 'package:refreshed/refreshed.dart';

class SudokuOfflinePage extends BaseView<SudokuOfflineController> {
  const SudokuOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Expanded(
          flex: 12,
          child: ListView(
            children: [
              SudokuOfflineBoardWidget(controller: controller),
              const SizedBox(height: 5),
              SudokuOfflineSelectNumberBox(controller: controller),
              const SizedBox(height: 15),
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
        Expanded(flex: 3, child: OfflineActivityButtons(controller: controller))
      ],
    );
  }
}
