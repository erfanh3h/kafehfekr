import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_text_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/Auth/Controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:refreshed/refreshed.dart';

class AuthPage extends BaseView<AuthController> {
  const AuthPage({super.key});

  @override
  bool resizeToAvoidBottomInset() {
    return true;
  }

  @override
  String? backgroundImage() {
    return AppImages.background3;
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s40Horizental,
        child: ListView(
          children: [
            SizedBox(height: 75.h),
            Image.asset(
              GeneralIcons.logoTransparent,
              width: 200.w,
              height: 200.w,
            ),
            SizedBox(height: 10.h),
            Center(
              child: GlobalFadeInOutTextBox(
                text: AppTexts.welcomeToCafeFekr.tr,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 30.h),
            if (controller.isPhonePhase.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.enterPhone.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 16,
                      fontFamily: FontFamilies.hekayat,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: GlobalInputBox(
                          label:
                              controller.isPhonePhase.value ? '9121234567' : '',
                          controller: controller.isPhonePhase.value
                              ? controller.phoneController
                              : controller.codeController,
                          textType: TextInputType.number,
                          maxLength: controller.isPhonePhase.value ? 10 : 4,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.enterUser,
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: AppSpacings.s10Top,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.25,
                          child: Checkbox(
                            value: controller.pricavyPolicyAccepted.value,
                            onChanged: controller.changePrivacyPolicyAccepted,
                            activeColor: AppColors.lightColor,
                            checkColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                width: 2.0,
                                color: AppColors.lightColor,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              ListView(
                                children: [
                                  Padding(
                                    padding: AppSpacings.s20All,
                                    child: Text(
                                      AppTexts.privacyPolicy.tr,
                                      style: const TextStyle(
                                        color: AppColors.lightColor,
                                        fontSize: 22,
                                        height: 1.75,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.darkColor,
                            );
                          },
                          child: Text(
                            AppTexts.iAcceptPrivacyPolicy.tr,
                            style: const TextStyle(
                              color: AppColors.lightColor,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.lightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.haveBackButton)
                        Expanded(
                          child: GlobalButtonWidget(
                            width: 125.w,
                            onTap: Get.back,
                            text: AppTexts.back.tr,
                          ),
                        ),
                      Expanded(
                        flex: 2,
                        child: GlobalButtonWidget(
                          width: 225.w,
                          onTap: controller.enterAsQuest,
                          text: AppTexts.enterAsQuest.tr,
                        ),
                      ),
                    ],
                  )
                ],
              )
            else
              !controller.isSendingData.value
                  ? Column(
                      children: [
                        Text(
                          "${AppTexts.enterCode.tr} : 0${controller.phoneController.text}",
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 22,
                            fontFamily: FontFamilies.hekayat,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 10.h),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            onCompleted: (pin) => controller.sendCode(),
                            controller: controller.codeController,
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: AppColors.lightColor,
                                fontFamily: FontFamilies.playPen,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            pinAnimationType: PinAnimationType.fade,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                AppTexts.didntGetCode.tr,
                                style: const TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: 15,
                                  decorationColor: AppColors.lightColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                AppTexts.resendCode.tr,
                                style: const TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.lightColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const GlobalLoadingWidget(
                      size: 45,
                      color: AppColors.lightColor,
                    ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
