import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class LudoUserWidget extends StatelessWidget {
  const LudoUserWidget({
    super.key,
    required this.count,
    required this.color,
  });

  final int count;
  final Color color;

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
              onTap: () {},
              color: index < count ? color : AppColors.transparent,
              borderColor: color,
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
  });

  final Function onTap;
  final Color? color;
  final Color? borderColor;

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
              color: borderColor ?? AppColors.lightColor,
              width: 2,
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
