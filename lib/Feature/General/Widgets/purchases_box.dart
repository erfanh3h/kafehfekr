import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:refreshed/refreshed.dart';

class PurchasesBox extends StatelessWidget {
  const PurchasesBox({
    super.key,
    required this.controller,
  });

  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: Get.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (ctx, index) => InkWell(
          onTap: () => controller.purchaseItem(index),
          child: Container(
            padding: AppSpacings.s2All,
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.lightColor),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: AppSpacings.s10All,
                    child: Row(
                      children: [
                        Text(
                          controller.counts[index].toString(),
                          style: const TextStyle(
                            fontSize: 21,
                            fontFamily: FontFamilies.dastnevis,
                            color: AppColors.lightColor,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Image.asset(
                            controller.images[index],
                            color: AppColors.goldenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: AppColors.lightColor,
                  child: Container(
                    width: double.maxFinite,
                    padding: AppSpacings.s5All,
                    child: Center(
                      child: Text(
                        controller.prices[index].toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamilies.typo,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: 6,
      ),
    );
  }
}
