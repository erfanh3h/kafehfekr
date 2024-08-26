import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class ClanPage extends StatelessWidget {
  const ClanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          AppTexts.kafehFekr.tr,
          style: const TextStyle(
            color: AppColors.lightColor,
            fontFamily: FontFamilies.dastnevis,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Center(
            child: Text(
              AppTexts.soon.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const GlobalBottomNavigationBar(),
      ],
    );
  }
}
