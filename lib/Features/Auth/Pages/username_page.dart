import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_text_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/Auth/Controllers/auth_controller.dart';
import 'package:refreshed/refreshed.dart';

class UsernamePage extends BaseView<AuthController> {
  const UsernamePage({super.key});

  @override
  String? backgroundImage() {
    return AppImages.background2;
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s10Horizental,
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
            GlobalFrameWrapper(
              frame: AppImages.board,
              padding: AppSpacings.s40All,
              child: Column(
                children: [
                  Text(
                    AppTexts.enterUsername.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200.w,
                    child: GlobalInputBox(
                      label: '',
                      controller: controller.usernameController,
                      textDirection: TextDirection.rtl,
                      maxLength: 30,
                      fontFamily: FontFamilies.hekayat,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   AppTexts.rIdReward.tr,
                  //   style: const TextStyle(
                  //     color: AppColors.lightColor,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // SizedBox(
                  //   width: 200.w,
                  //   child: GlobalInputBox(
                  //     label: "AabBcc",
                  //     controller: controller.rIdController,
                  //     textDirection: TextDirection.rtl,
                  //     maxLength: 6,
                  //   ),
                  // ),
                  const SizedBox(height: 25),
                  GlobalButtonWidget(
                    onTap: controller.sendUsername,
                    text: AppTexts.accept.tr,
                    color: AppColors.lightColor,
                    isLoading: controller.isSendingData.value,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}
