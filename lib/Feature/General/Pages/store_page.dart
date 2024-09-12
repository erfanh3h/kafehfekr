import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10Horizental,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            AppTexts.store.tr,
            style: const TextStyle(
              fontSize: 25,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Text(
                AppTexts.soon.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
