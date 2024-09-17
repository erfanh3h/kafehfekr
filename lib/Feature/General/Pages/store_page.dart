import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/chance_paper_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/purchases_box.dart';
import 'package:refreshed/refreshed.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.find<StoreController>();
    controller.checkCanGetFreeCoin();
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
              color: AppColors.goldenColor,
            ),
          ),
          const SizedBox(height: 20),
          FadeIn(
            delay: const Duration(milliseconds: 150),
            child: ChancePaperWidget(controller: controller),
          ),
          const Divider(
            height: 50,
            color: AppColors.lightColor,
          ),
          FadeIn(
            delay: const Duration(milliseconds: 300),
            child: PurchasesBox(controller: controller),
          ),
        ],
      ),
    );
  }
}
