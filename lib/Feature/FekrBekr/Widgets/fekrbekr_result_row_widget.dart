import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/FekrBekr/Widgets/fekrbekr_pin_box.dart';
import 'package:kafehfekr/Feature/FekrBekr/Widgets/fekrbekr_selection_row_box.dart';

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
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < selectionData.length; i++)
                    FekrBekrSelectionRowBox(value: selectionData[i]),
                ],
              ),
            ),
          ),
          // const Spacer(),
          Container(
            width: 55,
            height: 55,
            padding: AppSpacings.s5All,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10),
            ),
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
          Container(
            padding: AppSpacings.s5All,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightColor,
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(
                  color: AppColors.darkColor,
                  fontFamily: FontFamilies.dastnevis,
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
