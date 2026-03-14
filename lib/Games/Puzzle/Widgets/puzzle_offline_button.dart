import 'package:animate_do/animate_do.dart';
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
    required this.onTap,
    required this.index,
  });

  final PeaceModel data;
  final Function(int) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: data.id != 0
            ? FadeIn(
                duration: const Duration(milliseconds: 200),
                child: GlobalFrameWrapper(
                  frame: AppImages.button4,
                  padding: AppSpacings.s2All,
                  child: Center(
                    child: Text(
                      data.id.toString(),
                      style: TextStyle(
                          color: AppColors.lightColor,
                          fontSize: cons.maxWidth / 2),
                    ),
                  ),
                ),
              )
            : Container(),
      );
    });
  }
}
