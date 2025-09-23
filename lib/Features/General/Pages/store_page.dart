import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/store_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/chance_paper_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/purchases_box.dart';
import 'package:refreshed/refreshed.dart';

class StorePage extends BaseView<StoreController> {
  const StorePage({super.key});

  @override
  bool preventPop() {
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
          GlobalPageHeader(label: AppTexts.store.tr),
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
