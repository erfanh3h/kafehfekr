import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GlobalGameHeader extends StatelessWidget {
  const GlobalGameHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();
    return Padding(
      padding: AppSpacings.s10All,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: AppSpacings.s10All,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightColor),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.changePage(4);
                    },
                    child: const Icon(
                      CupertinoIcons.add,
                      color: AppColors.darkColor,
                    ),
                  ),
                  Text(
                    controller.myData.value!.score.toString(),
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 20,
                      color: AppColors.darkColor,
                    ),
                  ),
                  Image.asset(
                    GeneralIcons.coin,
                    width: 30,
                    height: 30,
                    color: AppColors.goldenColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: Container(
              padding: AppSpacings.s10All,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightColor),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      controller.myData.value!.score.toString(),
                      style: const TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 20,
                        color: AppColors.darkColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    GeneralIcons.cup,
                    width: 30,
                    height: 30,
                    color: AppColors.goldenColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          // Expanded(
          //   child: Text(
          //     AppTexts.kafehFekr.tr,
          //     style: const TextStyle(
          //       color: AppColors.lightColor,
          //       fontSize: 25,
          //       fontFamily: FontFamilies.dastnevis,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightColor),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 4),
                  Image.asset(
                    GeneralIcons.exp,
                    width: 30,
                    height: 30,
                    color: AppColors.goldenColor,
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      FunctionsLibraryClass.expToLabelExp(
                          controller.myData.value!.xp),
                      style: const TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 20,
                        color: AppColors.darkColor,
                      ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Container(
                    padding: AppSpacings.s10All,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.darkColor),
                      color: AppColors.goldenColor,
                    ),
                    child: Text(
                      FunctionsLibraryClass.expToLevel(
                              controller.myData.value!.xp)
                          .toString(),
                      style: const TextStyle(
                        fontFamily: FontFamilies.typo,
                        fontSize: 20,
                        color: AppColors.lightColor,
                      ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
