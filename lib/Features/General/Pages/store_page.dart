import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Features/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/chance_paper_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/purchases_box.dart';
import 'package:refreshed/refreshed.dart';

class StorePage extends BaseView<StoreController> {
  const StorePage({super.key});

  @override
  bool setWillPopScope() {
    return false;
  }

  @override
  Widget body(BuildContext context) {
    controller.checkCanGetFreeCoin();
    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppTexts.store.tr,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.lightColor,
                  ),
                ),
              ),
              backButton
            ],
          ),
          const SizedBox(height: 20),
          FadeIn(
            delay: const Duration(milliseconds: 150),
            child: ChancePaperWidget(controller: controller),
          ),
          const Center(
            child: SizedBox(
              height: 50,
              width: 100,
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Expanded(
            child: FadeIn(
              delay: const Duration(milliseconds: 300),
              child: PurchasesBox(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
