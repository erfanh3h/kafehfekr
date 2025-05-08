import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class OfflineGamesMenuController extends BaseController {
  onEachGameTap(OfflineGameTypes game) {
    switch (game) {
      case OfflineGameTypes.TicTacToe:
        Get.toNamed(AppRoutes.tictactoeOffline);
        return;
      case OfflineGameTypes.Ten:
        Get.toNamed(AppRoutes.tenOffline);
        return;
      case OfflineGameTypes.FekrBekr:
        Get.toNamed(AppRoutes.fekrBekrOffline);
        return;
      case OfflineGameTypes.Othello:
        Get.toNamed(AppRoutes.othelloOffline);
        return;
      case OfflineGameTypes.Sudoku:
        openSudokuSelector();
        return;
      case OfflineGameTypes.MSweeper:
        openMSweeperSelector();
      case OfflineGameTypes.MNumbers:
        openMNumbersSelector();
      case OfflineGameTypes.Mafia:
        openMafiaSelector();
      case OfflineGameTypes.Spy:
        openSpySelector();
        return;
    }
  }

  openMafiaSelector() {
    RxInt usersCount = RxInt(10);
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
                    "${AppTexts.usersCount.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: usersCount.value,
                      items: List.generate(40, (index) {
                        int number = index + 4;
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
                        usersCount.value = value ?? 10;
                      },
                    ),
                  ),
                ],
              ),
              GlobalButtonWidget(
                onTap: () {
                  Get.closeAllDialogs();
                  Get.toNamed(
                    AppRoutes.mafiaOffline,
                    arguments: usersCount.value,
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
                  Obx(
                    () => DropdownButton<int>(
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

  openSudokuSelector() {
    RxInt emptySize = RxInt(40);
    List<int> sizes = [20, 30, 40, 50, 60];
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
                    "${AppTexts.emptySize.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: emptySize.value,
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
                        emptySize.value = value ?? 6;
                      },
                    ),
                  ),
                ],
              ),
              GlobalButtonWidget(
                onTap: () {
                  Get.closeAllDialogs();
                  Get.toNamed(
                    AppRoutes.sudokuOffline,
                    arguments: emptySize.value,
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

  openSpySelector() {
    RxInt usersCount = RxInt(10);
    RxInt spiesSize = RxInt(2);
    RxInt timeValue = RxInt(5);
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.lightColor2,
          ),
          height: 200.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.usersCount.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: usersCount.value,
                      items: List.generate(30, (index) {
                        int number = index + 3; // از ۵ تا ۱۰
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
                        usersCount.value = value ?? 10;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.spiesCount.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: spiesSize.value,
                      items: List.generate(20, (index) {
                        int number = index + 1;
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
                        spiesSize.value = value ?? 2;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppTexts.timerValue.tr}: ",
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(
                    () => DropdownButton<int>(
                      value: timeValue.value,
                      items: List.generate(10, (index) {
                        int number = index + 2;
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
                        timeValue.value = value ?? 5;
                      },
                    ),
                  ),
                ],
              ),
              GlobalButtonWidget(
                onTap: () {
                  Get.closeAllDialogs();
                  Get.toNamed(
                    AppRoutes.spyOffline,
                    arguments: [
                      usersCount.value,
                      spiesSize.value,
                      timeValue.value
                    ],
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
