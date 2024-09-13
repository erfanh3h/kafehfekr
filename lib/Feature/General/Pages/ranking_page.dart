import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/ranking_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/ranking_row_box.dart';
import 'package:refreshed/refreshed.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController controller = Get.find<RankingController>();
    return Obx(
      () => Padding(
        padding: AppSpacings.s10Horizental,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              AppTexts.ranking.tr,
              style: const TextStyle(
                fontSize: 25,
                color: AppColors.lightColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GlobalButtonWidget(
                    onTap: () => controller.changeTab(0),
                    text: AppTexts.scoreBase.tr,
                    color: AppColors.lightColor.withOpacity(
                        controller.selectedTab.value == 0 ? .75 : .25),
                    fontColor: controller.selectedTab.value == 0
                        ? AppColors.darkColor
                        : AppColors.lightColor,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: GlobalButtonWidget(
                    onTap: () => controller.changeTab(1),
                    text: AppTexts.winBase.tr,
                    color: AppColors.lightColor.withOpacity(
                        controller.selectedTab.value == 1 ? .75 : .25),
                    fontColor: controller.selectedTab.value == 1
                        ? AppColors.darkColor
                        : AppColors.lightColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            controller.selectedTab.value == 0
                ? Expanded(
                    child: ListView.separated(
                      itemBuilder: (ctx, index) => RankingRowBox(
                        data: controller.byScoreData[index],
                        index: index + 1,
                      ),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 5),
                      itemCount: controller.byScoreData.length,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (ctx, index) => RankingRowBox(
                        data: controller.byWinData[index],
                        index: index + 1,
                      ),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 5),
                      itemCount: controller.byWinData.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
