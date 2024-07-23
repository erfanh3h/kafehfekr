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
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
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
                  child: Text(
                    'باشه',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
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
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s20All,
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
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13.sp,
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
                          style: TextStyle(
                            fontSize: 18.sp,
                            foreground: Paint()
                              ..strokeWidth = 1.5
                              ..color = Colors.black
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        if (cup != null || coin != null)
                          Padding(
                            padding: AppSpacings.s10Bottom,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (cup != null)
                                  Center(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          GeneralIcons.cup,
                                          width: 20.w,
                                          height: 20.w,
                                          color: AppColors.goldenColor,
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                          cup.toString(),
                                          style: TextStyle(
                                            fontFamily: FontFamilies.dastnevis,
                                            color: iconColor,
                                            fontSize: 20.sp,
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
                                        width: 20.w,
                                        height: 20.w,
                                        color: AppColors.goldenColor,
                                      ),
                                      const SizedBox(width: 1),
                                      Text(
                                        coin.toString(),
                                        style: TextStyle(
                                          fontFamily: FontFamilies.dastnevis,
                                          color: iconColor,
                                          fontSize: 20.sp,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        Image.asset(
                          icon,
                          color: iconColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
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
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 20.sp,
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
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: GlobalButtonWidget(
                      onTap: onAcceptTap,
                      text: AppTexts.accept.tr,
                    ),
                  ),
                  SizedBox(width: 4.w),
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
