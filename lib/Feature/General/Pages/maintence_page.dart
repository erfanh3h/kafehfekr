import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/maintence_controlle.dart';
import 'package:refreshed/refreshed.dart';

class MaintencePage extends BaseView<MaintenceController> {
  const MaintencePage({super.key});

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s15All,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              GeneralIcons.logoTransparent,
              width: 200.w,
              height: 200.w,
            ),
            SizedBox(height: 40.h),
            Text(
              'بازی تا حوالی ساعت  ${controller.fromNow} دردسترس نخواهد بود.',
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            GlobalButtonWidget(
              onTap: controller.onTap,
              text: AppTexts.exit.tr,
              color: AppColors.lightColor,
              fontColor: AppColors.darkColor,
            ),
          ],
        ),
      ),
    );
  }
}
