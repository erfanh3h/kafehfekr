import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Feature/Yinsh/Models/yinsh_piece_model.dart';

class YinshButton extends StatelessWidget {
  const YinshButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final YinshPieceModel peaceData;
  final Function(YinshPieceModel) onTap;

  @override
  Widget build(BuildContext context) {
    // Color? imageColor;
    String? image;
    // late double borderWidth;
    // Color borderColor;
    // final isLastTurnPlayed =
    //     peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [Colors.white24, (imageColor ?? Colors.white)],
            //   // stops: imageColor != null ? const [0, 0] : null,
            // ),
            // color: AppColors.lightColor,
            border: Border.all(
              // color: isLastTurnPlayed ? AppColors.yellow : borderColor,
              // width: isLastTurnPlayed ? 3 : borderWidth,
            ),
            shape: BoxShape.circle),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? ElasticIn(
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      image,
                      // color: imageColor,
                    ),
                  )
                : Container(),
      ),
    );
  }
}
