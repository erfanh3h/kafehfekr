import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class QueueFindingPart extends StatelessWidget {
  const QueueFindingPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          GeneralIcons.logoTransparent,
          // width: 200,
          height: 200,
          color: AppColors.lightColor,
        ),
        const SizedBox(height: 20),
        GlobalFadeInOutWidget(
          child: Text(
            AppTexts.findRivel.tr,
            style: const TextStyle(color: AppColors.lightColor, fontSize: 30),
          ),
        ),
        const Spacer(),
        GlobalButtonWidget(
          onTap: Get.back,
          text: AppTexts.back.tr,
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
