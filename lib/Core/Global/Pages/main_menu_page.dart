import 'dart:io';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button2.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_user_data_header.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/General/Widgets/change_username_box.dart';
import 'package:refreshed/refreshed.dart';

class ItemData {
  final String name;
  final IconData icon;
  final Function onTap;
  final double? scale;
  ItemData(this.name, this.icon, this.onTap, {this.scale = 1.0});
}

final items = [
  ItemData(bottomNavigationTexts[0], bottomNavigationIcons[0], () {
    Get.toNamed(AppRoutes.gamesMenu);
  }),
  ItemData(bottomNavigationTexts[1], bottomNavigationIcons[1], () {
    // Get.toNamed(AppRoutes.offlineGamesMenu);
  }),
  ItemData(bottomNavigationTexts[2], bottomNavigationIcons[2], () {
    Get.toNamed(AppRoutes.library);
  }),
  ItemData(bottomNavigationTexts[3], bottomNavigationIcons[3], () {
    Get.toNamed(AppRoutes.ranking);
  }),
  ItemData(bottomNavigationTexts[4], bottomNavigationIcons[4], () {
    // Get.toNamed(AppRoutes.history);
  }),
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
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: FadeInDown(
            delay: const Duration(seconds: 2),
            child: const GlobalUserDataHeader(),
          ),
        ),
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
                          color: AppColors.lightColor,
                          fontSize: 25,
                          fontFamily: FontFamilies.hekayat,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: AppSpacings.s5All,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.lightColor, width: 2),
                        ),
                        child: Icon(
                          items[index].icon,
                          color: AppColors.lightColor,
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
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: FadeInUp(
            delay: const Duration(seconds: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                GlobalActivityButton2(
                  text: AppTexts.store.tr,
                  iconData: Icons.shopify_sharp,
                  onTap: () {
                    Get.toNamed(AppRoutes.store);
                  },
                ),
                GetBuilder<SoundPlayerComponent>(builder: (cont) {
                  return Obx(
                    () => GlobalActivityButton2(
                      text: cont.letPlayMusic.value
                          ? AppTexts.musicOff.tr
                          : AppTexts.musicOn.tr,
                      icon: cont.letPlayMusic.value
                          ? GeneralIcons.soundOff
                          : GeneralIcons.soundOn,
                      onTap: () {
                        controller.changeLetPlayMusic(
                          !cont.letPlayMusic.value,
                        );
                        cont.changeLetPlayerSound(
                          !cont.letPlayMusic.value,
                          isGame: false,
                        );
                      },
                    ),
                  );
                }),
                GlobalActivityButton2(
                  text: AppTexts.changeUsername.tr,
                  iconData: CupertinoIcons.pen,
                  onTap: () {
                    Get.bottomSheet(
                      ChangeUsernameBox(
                        username: controller.myData.value!.name,
                        onChange: controller.changeUsername,
                      ),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                ),
                GlobalActivityButton2(
                  text: AppTexts.exit.tr,
                  icon: GeneralIcons.exit,
                  onTap: () {
                    exit(0);
                  },
                )
              ],
            ),
          ),
        ),
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