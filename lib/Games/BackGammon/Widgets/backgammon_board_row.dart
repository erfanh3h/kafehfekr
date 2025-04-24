import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/BackGammon/Models/backgammon_piece_model.dart';

class BackGammonBoardRow extends StatelessWidget {
  const BackGammonBoardRow({
    super.key,
    required this.peaceData,
    required this.onTap,
    this.isRight = true,
  });

  final BackGammonPeaceModel peaceData;
  final Function(BackGammonPeaceModel) onTap;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    late double pieceBorderWidth;
    late double boxBorderWidth;
    late Color boxBorderColor;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        break;
      default:
        imageColor = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      pieceBorderWidth = 2.5;
    } else {
      pieceBorderWidth = .5;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
      boxBorderWidth = 3;
      boxBorderColor = Colors.white70;
    } else {
      boxBorderWidth = .3;
      boxBorderColor = Colors.transparent;
    }
    return LayoutBuilder(builder: (context, cons) {
      double maxWidth = cons.maxWidth;
      double maxHeight = cons.maxHeight;
      return Container(
        margin: AppSpacings.s5Vertical,
        child: InkWell(
          onTap: () {
            onTap(peaceData);
          },
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomTriangleClipper(isRight: isRight),
                child: Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(isRight ? 255 : 1, 212, 133, 126),
                        Color.fromARGB(isRight ? 1 : 255, 214, 172, 168),
                      ],
                    ),
                    border: Border.all(
                      color:
                          isLastTurnPlayed ? AppColors.yellow : boxBorderColor,
                      width: isLastTurnPlayed ? 2 : boxBorderWidth,
                    ),
                  ),
                ),
              ),
              peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
                  ? const GlobalLoadingWidget()
                  : peaceData.count != 0
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: isRight
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            for (int i = 0; i < peaceData.count; i++)
                              ElasticIn(
                                child: Container(
                                  width: peaceData.count < 5
                                      ? 25
                                      : maxWidth / peaceData.count,
                                  height: maxHeight,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: imageColor,
                                    border: Border.all(
                                      color: AppColors.lightColor,
                                      width: pieceBorderWidth,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )
                      : Container(),
            ],
          ),
        ),
      );
    });
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  final bool isRight;

  CustomTriangleClipper({super.reclip, required this.isRight});
  @override
  Path getClip(Size size) {
    final path = Path();
    if (isRight) {
      path.moveTo(0, size.height / 2);
    } else {
      path.lineTo(size.width, size.height / 2);
    }
    if (isRight) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.lineTo(0, size.height);
    }
    // path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
