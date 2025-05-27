import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/ranking_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/ranking_row_box.dart';
import 'package:refreshed/refreshed.dart';

class RankingPage extends BaseView<RankingController> {
  const RankingPage({super.key});
  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Padding(
        padding: AppSpacings.s10Horizental,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GlobalPageHeader(label: AppTexts.ranking.tr),
            const SizedBox(height: 20),
            FadeIn(
              delay: const Duration(milliseconds: 150),
              child: Center(
                child: GlobalFrameWrapper(
                  padding: AppSpacings.s10All,
                  width: 200,
                  height: 60,
                  frame: AppImages.frame4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 0
                                ? AppColors.lightColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () => controller.changeTab(0),
                            child: Text(
                              AppTexts.scoreBase.tr,
                              style: TextStyle(
                                color: controller.selectedTab.value == 0
                                    ? AppColors.darkColor
                                    : AppColors.lightColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 1
                                ? AppColors.lightColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () => controller.changeTab(1),
                            child: Text(
                              AppTexts.winBase.tr,
                              style: TextStyle(
                                color: controller.selectedTab.value == 1
                                    ? AppColors.darkColor
                                    : AppColors.lightColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GlobalFrameWrapper(
                frame: AppImages.board,
                padding: AppSpacings.s30All,
                child: controller.isGettingData.value
                    ? const Center(
                        child: GlobalLoadingWidget(
                          color: AppColors.lightColor,
                          size: 125,
                        ),
                      )
                    : controller.selectedTab.value == 0
                        ? ListView.separated(
                            itemBuilder: (ctx, index) => RankingRowBox(
                              data: controller.byScoreData[index],
                              index: index + 1,
                            ),
                            separatorBuilder: (ctx, index) =>
                                const SizedBox(height: 5),
                            itemCount: controller.byScoreData.length,
                          )
                        : ListView.separated(
                            itemBuilder: (ctx, index) => RankingRowBox(
                              data: controller.byWinData[index],
                              index: index + 1,
                            ),
                            separatorBuilder: (ctx, index) =>
                                const SizedBox(height: 5),
                            itemCount: controller.byWinData.length,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
