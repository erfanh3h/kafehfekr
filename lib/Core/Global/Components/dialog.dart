import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/timer_dialog_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as st;

class DialogComponent {
  void showDialog(String title, String message) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s5All,
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
                  style: TextStyle(
                    fontSize: 13,
                    foreground: Paint()
                      ..strokeWidth = 1.25
                      ..color = Colors.black
                      ..style = PaintingStyle.stroke,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 22,
                    foreground: Paint()
                      ..strokeWidth = 1.25
                      ..color = Colors.black
                      ..style = PaintingStyle.stroke,
                  ),
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
    bool letBackPage = true,
    double fontSize = 22,
    Color? fontColor,
  }) {
    Get.dialog(
      barrierDismissible: false,
      // useSafeArea: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: AppSpacings.s20All,
          // width: Get.size.width.w.clamp(100, GeneralGameConsts.maxGameWidth),
          // height: Get.size.height * 3 / 10,
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  foreground: Paint()
                    ..strokeWidth = 1.25
                    ..color = Colors.black
                    ..style = PaintingStyle.stroke,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: fontSize,
                        foreground: Paint()
                          ..strokeWidth = 1.25
                          ..color = Colors.black
                          ..style = PaintingStyle.stroke,
                      ),
                      // maxLines: 3,
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
                    if (letBackPage) {
                      Get.back();
                    }
                  },
                  text: AppTexts.ok.tr,
                  color: iconColor,
                  fontColor: fontColor ?? AppColors.lightColor,
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
          // width: Get.size.width.w.clamp(100, GeneralGameConsts.maxGameWidth),
          // height: Get.size.height * 3 / 10,
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  foreground: Paint()
                    ..strokeWidth = 1.25
                    ..color = Colors.black
                    ..style = PaintingStyle.stroke,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
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

  showLoading() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: AppColors.darkRed,
        child: Padding(
          padding: AppSpacings.s20All,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTexts.wait.tr,
                style:
                    const TextStyle(fontSize: 21, color: AppColors.lightColor),
              ),
              const SizedBox(height: 15),
              const GlobalLoadingWidget(color: AppColors.lightColor),
            ],
          ),
        ),
      ),
    );
  }

  showTimerDialog({int time = 3, String? text}) {
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: AppColors.transparent,
          child: TimerDialogWidget(maxTime: time, text: text),
        ),
      ),
    );
  }

  void showToast({
    required String label,
    double? fontSize,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    st.showToast(
      label,
      context: Get.overlayContext,
      animation: st.StyledToastAnimation.sizeFade,
      backgroundColor: backgroundColor ?? AppColors.lightColor,
      textStyle: TextStyle(
        fontFamily: FontFamilies.dastnevis,
        fontSize: fontSize ?? 25,
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
