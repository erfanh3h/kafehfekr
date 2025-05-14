import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class LudoUserWidget extends StatelessWidget {
  const LudoUserWidget({
    super.key,
    required this.count,
    required this.color,
    required this.onTap,
    required this.canEquip,
    required this.outCount,
  });

  final int count;
  final Color color;
  final Function onTap;
  final bool canEquip;
  final int outCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Wrap(
        // spacing: 8.0,
        // runSpacing: 4.0,
        children: List.generate(
          4,
          (index) {
            return UseButton(
              onTap: () {
                if (canEquip) {
                  onTap();
                }
              },
              color: index < count ? color : AppColors.transparent,
              borderColor: color,
              canEquip: index < count && canEquip,
            );
          },
        ),
      ),
    );
  }
}

class UseButton extends StatelessWidget {
  const UseButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.borderColor,
    required this.canEquip,
  });

  final Function onTap;
  final Color? color;
  final Color? borderColor;
  final bool canEquip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [Colors.white24, (imageColor ?? Colors.white)],
            //   // stops: imageColor != null ? const [0, 0] : null,
            // ),
            color: Colors.transparent,
            // color: AppColors.lightColor,
            border: Border.all(
              color: canEquip
                  ? AppColors.goldenColor
                  : borderColor ?? AppColors.lightColor,
              width: canEquip ? 5 : 2,
            ),
            shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: color ?? Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: const Text(" "),
            ),
          ],
        ),
      ),
    );
  }
}
