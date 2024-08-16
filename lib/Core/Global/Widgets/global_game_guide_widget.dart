import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GlobalGameGuideWidget extends StatelessWidget {
  const GlobalGameGuideWidget({
    super.key,
    required this.gameType,
  });

  final GameTypes gameType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10All,
      child: ListView(
        children: [
          Center(
            child: Text(
              gameType.name.tr,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: FontFamilies.dastnevis,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            '${gameType.name}Guide'.tr,
            style: const TextStyle(
              fontSize: 21,
              fontFamily: FontFamilies.vazir,
            ),
          ),
        ],
      ),
    );
  }
}
