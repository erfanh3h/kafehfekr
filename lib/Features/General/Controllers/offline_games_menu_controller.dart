import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class OfflineGamesMenuController extends BaseController {
  onEachGameTap(GameTypes game) {
    switch (game) {
      case GameTypes.TicTacToe:
        Get.toNamed(AppRoutes.tictactoeOffline);
        return;
      case GameTypes.Ten:
        Get.toNamed(AppRoutes.tenOffline);
        return;
      case GameTypes.MSweeper:
        openMSweeperSelector();
      case GameTypes.MNumbers:
        openMNumbersSelector();
      default:
    }
  }

  openGameGuide(GameTypes gameType) {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  openMNumbersSelector() {
    RxInt boardSize = RxInt(6);
    List<int> sizes = [4, 6, 8, 10];
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.lightColor2,
          ),
          height: 150.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.boardSize.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: boardSize.value,
                      items: sizes.map((number) {
                        return DropdownMenuItem(
                          value: number,
                          child: Text(
                            number.toString(),
                            style: const TextStyle(
                              color: AppColors.darkColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        boardSize.value = value ?? 6;
                      },
                    ),
                  ),
                ],
              ),
              GlobalButtonWidget(
                onTap: () {
                  Get.closeAllDialogs();
                  Get.toNamed(
                    AppRoutes.mnumbersOffline,
                    arguments: boardSize.value,
                  );
                },
                text: AppTexts.start.tr,
              )
            ],
          ),
        ),
      ),
    );
  }

  openMSweeperSelector() {
    RxInt minesCont = RxInt(10);
    RxInt boardSize = RxInt(8);
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.lightColor2,
          ),
          height: 150.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.boardSize.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: boardSize.value,
                      items: List.generate(6, (index) {
                        int number = index + 5; // از ۵ تا ۱۰
                        return DropdownMenuItem(
                          value: number,
                          child: Text(
                            number.toString(),
                            style: const TextStyle(
                              color: AppColors.darkColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }),
                      onChanged: (value) {
                        boardSize.value = value ?? 8;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.minesCount.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  DropdownButton<int>(
                    value: minesCont.value,
                    items: List.generate(21, (index) {
                      int number = index + 5;
                      return DropdownMenuItem(
                        value: number,
                        child: Text(
                          number.toString(),
                          style: const TextStyle(
                            color: AppColors.darkColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      minesCont.value = value ?? 8;
                    },
                  ),
                ],
              ),
              GlobalButtonWidget(
                onTap: () {
                  Get.closeAllDialogs();
                  Get.toNamed(
                    AppRoutes.msweeperOffline,
                    arguments: [boardSize.value, minesCont.value],
                  );
                },
                text: AppTexts.start.tr,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
