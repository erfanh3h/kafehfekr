import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: controller.submitChoice,
                          icon: const Icon(
                            Icons.check,
                            size: 35,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: Get.size.width,
                  child: FekrBekrOfflineSelectNumbersBox(
                    controller: controller,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GetBuilder<FekrBekrOfflineController>(
                builder: (context) {
                  return Container(
                    padding: AppSpacings.s5All,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.lightColor, width: 3),
                    ),
                    child: Obx(
                      () => ListView.builder(
                        controller: controller.historyController,
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
