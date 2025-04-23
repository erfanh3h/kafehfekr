import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_offline_controller.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_offline_board_widget.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperOfflinePage extends BaseView<MSweeperOfflineController> {
  const MSweeperOfflinePage({super.key});

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
          Expanded(
            child: Center(
              child: Text(
                controller.isGameFinished.value
                    ? controller.gameResultText.value
                    : 'خانه ی باقیمانده  :  ${controller.allPiecesCount.value - controller.defusedPieces.value - controller.minesCount.value}',
                style: const TextStyle(
                    fontFamily: FontFamilies.hekayat,
                    fontSize: 30,
                    color: AppColors.lightColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: MSweeperOfflineBoardWidget(controller: controller),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlobalButtonWidget(
                  onTap: controller.resetGame,
                  text: AppTexts.restart.tr,
                ),
                GlobalButtonWidget(
                  onTap: controller.exitGame,
                  text: AppTexts.exit.tr,
                ),
                // DropdownButton<int>(
                //   hint: const Text('یک عدد انتخاب کنید'),
                //   value: controller.boardSize.value,
                //   items: List.generate(6, (index) {
                //     int number = index + 5; // از ۵ تا ۱۰
                //     return DropdownMenuItem(
                //       value: number,
                //       child: Text(number.toString()),
                //     );
                //   }),
                //   onChanged: (value) {
                //     controller.boardSize.value = value ?? 8;
                //   },
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
