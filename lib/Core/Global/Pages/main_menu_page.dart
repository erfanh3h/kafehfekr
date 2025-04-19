import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_header.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Pages/store_page.dart';
import 'package:kafehfekr/Feature/General/Pages/game_menu_page.dart';
import 'package:kafehfekr/Feature/General/Pages/profile_page.dart';
import 'package:kafehfekr/Feature/General/Pages/ranking_page.dart';
import 'package:kafehfekr/Feature/General/Pages/library_page.dart';
import 'package:refreshed/refreshed.dart';

class ItemData {
  final String name;
  final IconData icon;
  final Function onTap;
  final double? scale;
  ItemData(this.name, this.icon, this.onTap, {this.scale = 1.0});
}

final items = [
  ItemData(bottomNavigationTexts[0], bottomNavigationIcons[0], () {}),
  ItemData(bottomNavigationTexts[1], bottomNavigationIcons[1], () {}),
  ItemData(bottomNavigationTexts[2], bottomNavigationIcons[2], () {
    print("start game");
  }),
  ItemData(bottomNavigationTexts[3], bottomNavigationIcons[3], () {}),
  ItemData(bottomNavigationTexts[4], bottomNavigationIcons[4], () {}),
];

class MainPage extends BaseView<GlobalController> {
  const MainPage({super.key});

  Widget buildSemiCircularItems({
    required List<ItemData> items,
    required Offset center,
    required double radius,
  }) {
    return Stack(
      children: [
        // const Positioned(
        //   top: 0,
        //   right: 0,
        //   left: 0,
        //   child: GlobalGameHeader(),
        // ),
        Positioned(
          left: center.dx - 20,
          top: center.dy - 60,
          child: GlobalFadeInOutWidget(
            child: Image.asset(
              GeneralIcons.logoTransparent,
              width: 150,
              height: 150,
            ),
          ),
        ),

        // 🔄 چیدن آیتم‌ها روی نیم‌دایره
        ...List.generate(items.length, (index) {
          final angle = (-math.pi / 2) +
              (math.pi / 6) +
              (math.pi * 2 / 3 / (items.length - 1)) * index;

          final x = radius * 2 / 3 * math.cos(angle);
          final y = radius * math.sin(angle);

          return Positioned(
            left: center.dx + x,
            top: center.dy + y - 20,
            child: FadeInRight(
              delay: Duration(milliseconds: index * 500),
              child: InkWell(
                onTap: () => items[index].onTap(),
                child: Transform.scale(
                  scale: items[index].scale,
                  child: Row(
                    children: [
                      Text(
                        items[index].name.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: FontFamilies.hekayat,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: AppSpacings.s5All,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          items[index].icon,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

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
      child: buildSemiCircularItems(
        items: items,
        center: Offset(40, Get.size.height / 2),
        radius: 240,
      ),
    );
  }
}


        // ProfilePage(),
        //         RankingPage(),
        //         GameMenuPage(),
        //         LibraryPage(),
        //         StorePage(),