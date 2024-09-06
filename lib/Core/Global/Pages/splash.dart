import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    globalController.checkLoginStatus();
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            GeneralIcons.logoTransparent,
            width: 200.w,
            height: 200.w,
          ),
          SizedBox(height: 30.h),
          Obx(
            () => globalController.errorGetData.value
                ? GlobalButtonWidget(
                    onTap: () {
                      exit(0);
                    },
                    text: AppTexts.exit.tr,
                  )
                : const GlobalLoadingWidget(
                    color: AppColors.lightColor,
                  ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Text(
              AppTexts.kafehfekrNarratie.tr,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: FontFamilies.dastnevis,
                color: AppColors.lightColor,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
