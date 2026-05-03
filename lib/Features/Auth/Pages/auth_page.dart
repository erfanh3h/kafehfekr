import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_text_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/Auth/Controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:refreshed/refreshed.dart';

class AuthPage extends BaseView<AuthController> {
  const AuthPage({super.key});

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s20Horizental,
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: GlobalFadeInOutTextBox(
                text: AppTexts.welcomeToCafeFekr.tr,
                fontSize: 30,
              ),
            ),
            const Spacer(),
            if (controller.isPhonePhase.value)
              GlobalFrameWrapper(
                frame: AppImages.board,
                padding: AppSpacings.s30All,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppSpacings.s30Horizental,
                      child: Text(
                        AppTexts.enterPhone.tr,
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontSize: 16,
                          fontFamily: FontFamilies.hekayat,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: Row(
                        children: [
                          Expanded(
                            child: GlobalInputBox(
                              label: controller.isPhonePhase.value
                                  ? '9121234567'
                                  : '',
                              controller: controller.isPhonePhase.value
                                  ? controller.phoneController
                                  : controller.codeController,
                              textType: TextInputType.number,
                              maxLength: controller.isPhonePhase.value ? 10 : 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.haveBackButton)
                          Container(
                            margin: AppSpacings.s5Left,
                            child: GlobalButtonWidget(
                              width: 100,
                              onTap: Get.back,
                              text: AppTexts.back.tr,
                            ),
                          ),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: GlobalButtonWidget(
                            onTap: controller.enterUser,
                            text: AppTexts.accept.tr,
                            fontSize: 25,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextButton(
                            onPressed: controller.enterAsQuest,
                            child: Text(
                              AppTexts.enterAsQuest.tr,
                              style: TextStyle(
                                  color: AppColors.background, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            else
              !controller.isSendingData.value
                  ? GlobalFrameWrapper(
                      frame: AppImages.board,
                      padding: AppSpacings.s40All,
                      child: Column(
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
                      ),
                    )
                  : const GlobalLoadingWidget(
                      size: 45,
                      color: AppColors.lightColor,
                    ),
            const Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}
