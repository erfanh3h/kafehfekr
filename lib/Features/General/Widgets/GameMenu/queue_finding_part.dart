import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class QueueFindingPart extends StatelessWidget {
  const QueueFindingPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GlobalFrameWrapper(
          frame: AppImages.bilboard2,
          height: 200,
          width: Get.size.width / 2,
          child: Padding(
            padding: AppSpacings.s50Top,
            child: Center(
              child: Text(
                AppTexts.twoPlayersGame.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 50,
                  fontFamily: FontFamilies.hekayat,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: GlobalFrameWrapper(
            padding: AppSpacings.s50All,
            frame: AppImages.board,
            width: double.maxFinite,
            child: ListView(
              children: const [
                SizedBox(height: 10),
                Text(
                  "guide",
                  style: TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 17,
                    fontFamily: FontFamilies.hekayat,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          spacing: 5,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: GlobalFrameWrapper(
                frame: AppImages.frame,
                child: GlobalFadeInOutWidget(
                  child: Center(
                    child: Text(
                      AppTexts.findRivel.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor2,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: Get.back,
              child: const GlobalFrameWrapper(
                frame: AppImages.reply,
                child: SizedBox(
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}
