import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Pages/game_menu_page.dart';
import 'package:refreshed/refreshed.dart';

class MainMenuPage extends BaseView<GlobalController> {
  const MainMenuPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      width: Get.size.width,
      height: Get.size.height,
      padding: AppSpacings.s10All,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) async {
          if (index > 4) {
            return;
          }
          controller.changePage(index);
        },
        controller: controller.pgCtrl,
        children: const [
          GameMenuPage(),
          GameMenuPage(),
          GameMenuPage(),
          GameMenuPage(),
          GameMenuPage(),
        ],
      ),
    );
  }
}
