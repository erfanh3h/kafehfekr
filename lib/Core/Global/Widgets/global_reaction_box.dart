import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReactionBox extends StatefulWidget {
  const ReactionBox({
    super.key,
    required this.reactionId,
  });

  final int? reactionId;

  @override
  State<ReactionBox> createState() => _ReactionBoxState();
}

class _ReactionBoxState extends State<ReactionBox>
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
    double dy = 0;
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
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Image.asset(
              ReactionIcons().generalIconsPath(widget.reactionId!),
              width: 25.r,
              height: 25.r,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
