import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background2),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            const GlobalLoadingWidget(
              color: AppColors.lightColor,
              size: 200,
            ),
            SizedBox(height: 35.h),
            Padding(
              padding: AppSpacings.s20Horizental,
              child: Text(
                AppTexts.kafehfekrNarratie.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: FontFamilies.dastnevis,
                  color: AppColors.lightColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15.h),
            // Obx(() => globalController.errorGetData.value
            //     ? GlobalButtonWidget(
            //         onTap: () {
            //           exit(0);
            //         },
            //         text: AppTexts.exit.tr,
            //         color: AppColors.darkRed,
            //       )
            //     : Container()),
          ],
        ),
      ),
    );
  }
}
