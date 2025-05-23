import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/FekrBekr/Controllers/fekrbekr_offline_controller.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_button.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_offline_select_numbers_box.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_result_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrOfflineBoardWidget extends StatelessWidget {
  const FekrBekrOfflineBoardWidget({
    super.key,
    required this.controller,
  });

  final FekrBekrOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s15All,
        // height:
        //     (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) + 100,
        // width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalFrameWrapper(
              frame: AppImages.frame4,
              padding: AppSpacings.s25All,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            for (int i = 0; i < 4; i++)
                              Obx(
                                () => FekrBekrButton(
                                  peaceData: controller.peaces[i].value,
                                  onTap: controller.onEachButtonTap,
                                ),
                              ),
                          ],
                        ),
                      ),
                      GlobalFrameWrapper(
                        padding: AppSpacings.s10All,
                        frame: AppImages.check,
                        child: InkWell(
                          onTap: controller.submitChoice,
                          child: const SizedBox(
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: Get.size.width,
                    child: FekrBekrOfflineSelectNumbersBox(
                      controller: controller,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GetBuilder<FekrBekrOfflineController>(
                builder: (context) {
                  return GlobalFrameWrapper(
                    padding: AppSpacings.s25All,
                    frame: AppImages.board,
                    child: Obx(
                      () => ListView.separated(
                        itemBuilder: (ctx, index) {
                          final int reversedIndex =
                              controller.playerResults.length - index - 1;
                          return FekrBekrResultRowWidget(
                            selectionData:
                                controller.playerChoices[reversedIndex],
                            resultData: controller.playerResults[reversedIndex],
                            index: reversedIndex,
                          );
                        },
                        separatorBuilder: (ctx, index) =>
                            const SizedBox(height: 10),
                        itemCount: controller.playerResults.length,
                      ),
                    ),
                  );
                },
              ),
            ),
            // const Divider(color: AppColors.lightColor, height: 30),
          ],
        ),
      ),
    );
  }
}
