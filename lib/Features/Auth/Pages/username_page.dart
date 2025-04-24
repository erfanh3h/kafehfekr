import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_text_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/Auth/Controllers/auth_controller.dart';
import 'package:refreshed/refreshed.dart';

class UsernamePage extends BaseView<AuthController> {
  const UsernamePage({super.key});
  @override
  bool resizeToAvoidBottomInset() {
    return true;
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
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              AppTexts.rIdReward.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 200.w,
              child: GlobalInputBox(
                label: "AabBcc",
                controller: controller.rIdController,
                textDirection: TextDirection.rtl,
                maxLength: 6,
              ),
            ),
            SizedBox(height: 50.h),
            GlobalButtonWidget(
              onTap: controller.sendUsername,
              text: AppTexts.accept.tr,
              color: AppColors.lightColor,
              fontColor: AppColors.darkColor,
              isLoading: controller.isSendingData.value,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
