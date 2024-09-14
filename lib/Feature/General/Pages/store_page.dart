import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:refreshed/refreshed.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.find<StoreController>();
    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            AppTexts.store.tr,
            style: const TextStyle(
              fontSize: 25,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.maxFinite,
            height: 75,
            padding: AppSpacings.s40Horizental,
            child: GlobalButtonWidget(
              onTap: controller.getFreeCoin,
              text: controller.canGetFreeCoin.value
                  ? AppTexts.chancePaper.tr
                  : 'تا ${controller.remainTimeText.value} صبر کن',
              color: AppColors.redWarmColor
                  .withOpacity(controller.canGetFreeCoin.value ? 1 : .25),
            ),
          )
        ],
      ),
    );
  }
}
