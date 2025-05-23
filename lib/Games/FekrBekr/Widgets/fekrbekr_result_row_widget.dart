import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_pin_box.dart';
import 'package:kafehfekr/Games/FekrBekr/Widgets/fekrbekr_selection_row_box.dart';

class FekrBekrResultRowWidget extends StatelessWidget {
  const FekrBekrResultRowWidget({
    super.key,
    required this.selectionData,
    required this.resultData,
    required this.index,
  });

  final List<int> selectionData;
  final List<int> resultData;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Expanded(
            child: GlobalFrameWrapper(
              padding: AppSpacings.s10All,
              frame: AppImages.frame4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < selectionData.length; i++)
                    FekrBekrSelectionRowBox(value: selectionData[i]),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          GlobalFrameWrapper(
            width: 55,
            height: 55,
            frame: AppImages.button4,
            padding: AppSpacings.s5All,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (ctx, index) => FekrBekrPinBox(
                value: resultData[index],
              ),
              itemCount: resultData.length,
            ),
          ),
          const SizedBox(width: 5),
          GlobalFrameWrapper(
            padding: AppSpacings.s5All,
            width: 30,
            height: 30,
            frame: AppImages.button4,
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontFamily: FontFamilies.hekayat,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
