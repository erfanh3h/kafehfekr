import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GlobalWaitWidget extends StatelessWidget {
  const GlobalWaitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        AppTexts.wait.tr,
        style: const TextStyle(
          color: AppColors.peaceBorderColor,
          fontSize: 22,
        ),
      );
  }
}
