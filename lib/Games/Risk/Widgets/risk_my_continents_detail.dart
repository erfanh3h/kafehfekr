import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Risk/Models/enums.dart';
import 'package:refreshed/route_manager.dart';
import 'package:refreshed/utils.dart';

class RiskMyContinentsWidget extends StatelessWidget {
  const RiskMyContinentsWidget({super.key, required this.continents});

  final Map<ContinentTypes, int> continents;
  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.board,
      height: Get.size.height / 2,
      width: Get.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s5All,
            child: Text(
              AppTexts.myContinents.tr,
              style: const TextStyle(color: AppColors.lightColor, fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (ctx, index) {
                  final continent = continents.keys.toList()[index];
                  final iconData = continentToImage(continent);
                  final text = continent.name.tr;
                  final count = continents[continent];
                  return GlobalFrameWrapper(
                    padding: AppSpacings.s5All,
                    // height: 120,
                    // width: 150,
                    frame: AppImages.dialog2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(iconData),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Center(
                              child: Text(
                                count.toString(),
                                style: const TextStyle(
                                  color: AppColors.darkColor,
                                  fontSize: 60,
                                  fontFamily: FontFamilies.playPen,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          text,
                          style: const TextStyle(
                              color: AppColors.lightColor, fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: continents.keys.length,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
