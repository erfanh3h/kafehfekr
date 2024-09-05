import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Widgets/avatars_selection_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:refreshed/refreshed.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlobalController>();
    controller.fetchMyHistoryData();
    return Obx(
      () => controller.isLoadingHistory.value
          ? const Center(
              child: GlobalLoadingWidget(
                color: AppColors.lightColor,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                FadeInDown(
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        AvatarsSelectionBox(
                          onTap: controller.changeProfile,
                        ),
                        backgroundColor: AppColors.darkColor,
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      padding: AppSpacings.s5All,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.goldenColor, width: 3)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(
                          AvatarIcons()
                              .generalAvatarPath(controller.myData.value!.image),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeIn(
                  child: Text(
                    controller.myData.value!.name,
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.lightColor,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  child: Padding(
                    padding: AppSpacings.s10Horizental,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextNumberWidget(
                              text: AppTexts.win.tr,
                              number: controller.myHistoryData.value!.winNormal),
                        ),
                        Expanded(
                          child: TextNumberWidget(
                              text: AppTexts.draw.tr,
                              number: controller.myHistoryData.value!.drawNormal),
                        ),
                        Expanded(
                          child: TextNumberWidget(
                              text: AppTexts.lose.tr,
                              number: controller.myHistoryData.value!.loseNormal),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class TextNumberWidget extends StatelessWidget {
  const TextNumberWidget({
    super.key,
    required this.text,
    required this.number,
  });

  final String text;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightColor,
      child: Padding(
        padding: AppSpacings.s15All,
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.darkColor,
              ),
            ),
            Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.darkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
