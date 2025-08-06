import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class PuzzleOfflineButtonWidget extends StatelessWidget {
  const PuzzleOfflineButtonWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final PeaceModel data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("object"),
      child: data.id != 0
          ? GlobalFrameWrapper(
              frame: AppImages.button4,
              padding: AppSpacings.s2All,
              child: Center(
                child: Text(
                  data.id.toString(),
                  style: const TextStyle(
                      color: AppColors.lightColor, fontSize: 35),
                ),
              ),
            )
          : Container(),
    );
  }
}
