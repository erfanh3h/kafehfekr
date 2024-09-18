import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/FekrBekr/Models/fekrbekr_piece_model.dart';

class FekrBekrButton extends StatelessWidget {
  const FekrBekrButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final FekrBekrPeaceModel peaceData;
  final Function(FekrBekrPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    // late double borderWidth;
    imageColor = AppColors.lightColor;
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        // width: 35,
        // height: 35,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.white24, (imageColor)],
              // stops: imageColor != null ? const [0, 0] : null,
            ),
            // color: AppColors.lightColor,
            border: Border.all(
              color: imageColor,
              width: 1,
            ),
            shape: BoxShape.circle),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : peaceData.value != null
                ? ElasticIn(
                    duration: const Duration(milliseconds: 750),
                    child: Center(
                      child: Text(
                        peaceData.value.toString(),
                        style: const TextStyle(
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 25,
                          color: AppColors.lightColor,
                        ),
                      ),
                    ),
                  )
                : Container(),
      ),
    );
  }
}
