import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/multi_queue_controller.dart';
import 'package:refreshed/refreshed.dart';

class MultiQueuePage extends BaseView<MultiQueueController> {
  const MultiQueuePage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  String? backgroundImage() {
    return AppImages.background3;
  }

  @override
  Widget body(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.maxFinite,
      child: Column(
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
