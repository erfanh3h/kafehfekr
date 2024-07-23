import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalReactionBox extends StatefulWidget {
  const GlobalReactionBox({
    super.key,
    required this.reactionId,
    this.color,
  });

  final int? reactionId;
  final Color? color;

  @override
  State<GlobalReactionBox> createState() => _GlobalReactionBoxState();
}

class _GlobalReactionBoxState extends State<GlobalReactionBox>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    if (widget.reactionId == null) {
      try {
        animation.dispose();
      } catch (_) {}
    } else {
      animation = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
      _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 3)).then((_) {
            animation.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          animation.forward();
        }
      });
      animation.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dx = 0;
    double dy = 55.h;
    // switch (widget.playerPosition) {
    //   case PlayerPositionOnBoard.center:
    //     dy = -40;
    //     break;
    //   case PlayerPositionOnBoard.left:
    //     dx = -40;
    //     break;
    //   case PlayerPositionOnBoard.right:
    //     dx = 40;
    //     break;
    //   default:
    // }
    return Transform.translate(
      offset: Offset(dx, dy),
      child: Center(
        child: Container(
          padding: AppSpacings.s5All,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightColor,
            border: Border.all(
              color: widget.color ?? Colors.black,
              width: 2,
            ),
          ),
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Image.asset(
              ReactionIcons().generalIconsPath(widget.reactionId!),
              width: 35.r,
              height: 35.r,
              color: widget.color ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
