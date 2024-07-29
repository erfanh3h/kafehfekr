import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class DialogComponent {
  void showDialog(String title, String message) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s20All,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.closeAllDialogs();
                },
                child: Container(
                  padding: AppSpacings.s20Horizental10Vertical,
                  decoration: BoxDecoration(
                    color: AppColors.blueWarmColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'باشه',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showIconicDialog(
    String title,
    String message,
    String icon,
    Color iconColor, {
    int? cup,
    int? coin,
    int? star,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s20All,
          width: Get.size.width.w.clamp(100, GeneralGameConsts.maxGameWidth),
          height: Get.size.height * 3 / 10,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: iconColor,
              width: 5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      foreground: Paint()
                        ..strokeWidth = 2
                        ..color = Colors.black
                        ..style = PaintingStyle.stroke,
                    ),
                  ),
                  if (cup != null)
                    Center(
                      child: Row(
                        children: [
                          Image.asset(
                            GeneralIcons.cup,
                            width: 20,
                            height: 20,
                            color: AppColors.goldenColor,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            cup.toString(),
                            style: const TextStyle(
                              fontFamily: FontFamilies.dastnevis,
                              color: AppColors.goldenColor,
                              fontSize: 20,
                            ),
                            textDirection: TextDirection.ltr,
                          )
                        ],
                      ),
                    ),
                  if (coin != null)
                    Row(
                      children: [
                        Image.asset(
                          GeneralIcons.coin,
                          width: 20,
                          height: 20,
                          color: AppColors.goldenColor,
                        ),
                        const SizedBox(width: 1),
                        Text(
                          coin.toString(),
                          style: const TextStyle(
                            fontFamily: FontFamilies.dastnevis,
                            color: AppColors.goldenColor,
                            fontSize: 20,
                          ),
                          textDirection: TextDirection.ltr,
                        )
                      ],
                    ),
                  if (star != null)
                    Row(
                      children: [
                        Image.asset(
                          GeneralIcons.star,
                          width: 20,
                          height: 20,
                          color: AppColors.goldenColor,
                        ),
                        const SizedBox(width: 1),
                        Text(
                          star.toString(),
                          style: const TextStyle(
                            fontFamily: FontFamilies.dastnevis,
                            color: AppColors.goldenColor,
                            fontSize: 20,
                          ),
                          textDirection: TextDirection.ltr,
                        )
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 22,
                        foreground: Paint()
                          ..strokeWidth = 1.5
                          ..color = Colors.black
                          ..style = PaintingStyle.stroke,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Image.asset(
                    icon,
                    color: iconColor,
                    width: Get.size.width.w
                            .clamp(100, GeneralGameConsts.maxGameWidth) /
                        5,
                    height: Get.size.width.w
                            .clamp(100, GeneralGameConsts.maxGameWidth) /
                        5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.size.width / 2,
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.closeAllDialogs();
                  },
                  text: AppTexts.ok.tr,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showIconicSelectionDialog(
    String title,
    String message,
    String icon,
    Color iconColor,
    VoidCallback onAcceptTap,
    VoidCallback onCancelTap,
  ) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s20All,
          width: Get.size.width.w.clamp(100, GeneralGameConsts.maxGameWidth),
          height: Get.size.height / 4,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: iconColor,
              width: 5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            foreground: Paint()
                              ..strokeWidth = 2
                              ..color = Colors.black
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      icon,
                      color: iconColor,
                      width: Get.size.width.w
                              .clamp(100, GeneralGameConsts.maxGameWidth) /
                          5,
                      height: Get.size.width.w
                              .clamp(100, GeneralGameConsts.maxGameWidth) /
                          5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: GlobalButtonWidget(
                      onTap: onAcceptTap,
                      text: AppTexts.accept.tr,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: GlobalButtonWidget(
                      onTap: onCancelTap,
                      text: AppTexts.cancel.tr,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
