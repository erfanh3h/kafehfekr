import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/General/Pages/clan_page.dart';
import 'package:kafehfekr/Feature/General/Pages/game_menu_page.dart';
import 'package:kafehfekr/Feature/General/Pages/profile_page.dart';
import 'package:kafehfekr/Feature/General/Pages/ranking_page.dart';
import 'package:kafehfekr/Feature/General/Pages/settings_page.dart';
import 'package:refreshed/refreshed.dart';

class MainPage extends BaseView<GlobalController> {
  const MainPage({super.key});

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
      child: Column(
        children: [
          Image.asset(
            GeneralIcons.logoTransparent,
            width: 75.h,
            height: 75.h,
          ),
          Expanded(
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
                ProfilePage(),
                RankingPage(),
                GameMenuPage(),
                ClanPage(),
                SettingsPage(),
              ],
            ),
          ),
          const GlobalBottomNavigationBar(),
        ],
      ),
    );
  }
}
