import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Feature/BackGammon/Widgets/backgammon_board_row.dart';
import 'package:refreshed/refreshed.dart';

class BackGammonBoardWidget extends StatelessWidget {
  const BackGammonBoardWidget({
    super.key,
    required this.controller,
  });

  final BackGammonController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s5All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) + 100.h,
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: AppSpacings.s10All,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.goldenColor2,
                    width: 10,
                  ),
                  color: Colors.transparent.withOpacity(.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 23; i >= 18; i--)
                              Expanded(
                                child: BackGammonBoardRow(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 0; i < 6; i++)
                              Expanded(
                                child: BackGammonBoardRow(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                  isRight: false,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              child: Row(),
            ),
            // const Divider(color: Colors.white, height: 10),
            Expanded(
              child: Container(
                padding: AppSpacings.s10All,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.goldenColor2,
                    width: 10,
                  ),
                  color: Colors.transparent.withOpacity(.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 17; i >= 12; i--)
                              Expanded(
                                child: BackGammonBoardRow(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 6; i < 12; i++)
                              Expanded(
                                child: BackGammonBoardRow(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                  isRight: false,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
