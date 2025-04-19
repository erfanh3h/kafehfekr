import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Feature/General/Widgets/chance_paper_widget.dart';
import 'package:kafehfekr/Feature/General/Widgets/purchases_box.dart';

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
          Expanded(
            child: FadeIn(
              delay: const Duration(milliseconds: 300),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  FadeIn(
                    delay: const Duration(milliseconds: 150),
                    child: ChancePaperWidget(controller: controller),
                  ),
                  const Divider(
                    height: 50,
                    color: AppColors.lightColor,
                  ),
                  PurchasesBox(controller: controller),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
