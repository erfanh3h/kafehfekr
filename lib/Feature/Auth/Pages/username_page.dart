import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Auth/Controllers/auth_controller.dart';
import 'package:refreshed/refreshed.dart';

class UsernamePage extends BaseView<AuthController> {
  const UsernamePage({super.key});

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
            SizedBox(height: 20.h),
            Text(
              AppTexts.enterUsername.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 200.w,
              child: GlobalInputBox(
                label: '',
                controller: controller.usernameController,
              ),
            ),
            const SizedBox(height: 40),
            GlobalButtonWidget(
              onTap: controller.sendUsername,
              text: AppTexts.accept.tr,
              color: AppColors.lightColor,
              fontColor: AppColors.darkColor,
              isLoading: controller.isSendingData.value,
            ),
          ],
        ),
      ),
    );
  }
}
