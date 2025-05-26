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

class RiskMyTokensWidget extends StatelessWidget {
  const RiskMyTokensWidget({super.key, required this.tokens});

  final List<ContinentTypes> tokens;
  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.board,
      height: Get.size.height * 2 / 5,
      width: Get.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s5All,
            child: Text(
              AppTexts.myTokens.tr,
              style: const TextStyle(color: AppColors.lightColor, fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 3,
                childAspectRatio: 4 / 4,
              ),
              itemBuilder: (ctx, index) {
                final continent = tokens[index];
                final text = continent.name.tr;
                return GlobalFrameWrapper(
                  padding: AppSpacings.s5All,
                  frame: AppImages.button5,
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 20,
                        fontFamily: FontFamilies.playPen,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                );
              },
              itemCount: tokens.length,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
