import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class GlobalGameQueueBox extends StatefulWidget {
  const GlobalGameQueueBox({
    super.key,
    required this.controller,
  });

  final GlobalController controller;
  @override
  State<GlobalGameQueueBox> createState() => _GlobalGameQueueBoxState();
}

class _GlobalGameQueueBoxState extends State<GlobalGameQueueBox>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2)).then((_) {
          animation.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(1, 212, 133, 126),
              AppColors.darkColor,
            ],
          ),
          border: Border.all(
            color: Colors.white70,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: widget.controller.stopQueue,
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.lightColor,
              ),
            ),
            const SizedBox(width: 5),
            FadeTransition(
              opacity: _fadeInFadeOut,
              child: Text(
                'در جست و جوی بازی ${widget.controller.activeQueueType.value.tr} ...',
                style: TextStyle(
                  fontSize: 16,
                  foreground: Paint()
                    ..strokeWidth = 1.5
                    ..color = AppColors.lightColor
                    ..style = PaintingStyle.stroke,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
