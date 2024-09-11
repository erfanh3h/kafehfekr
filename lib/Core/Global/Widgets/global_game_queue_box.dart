import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
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
          try {
            animation.reverse();
          } catch (_) {}
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
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              const Color.fromARGB(1, 212, 133, 126),
              widget.controller.activeQueueScoreType.value == "Normal"
                  ? AppColors.green
                  : AppColors.redWarmColor,
            ],
          ),
          border: Border.all(
            color: Colors.white70,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => widget.controller.isQueueLoading.value
              ? const Center(
                  child: GlobalLoadingWidget(
                    size: 10,
                    color: Colors.white,
                  ),
                )
              : Row(
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
                        'در جست و جوی بازیکن ${widget.controller.activeQueueType.value.tr} ...',
                        style: TextStyle(
                          fontSize: 16,
                          foreground: Paint()
                            ..strokeWidth = 1.1
                            ..color = AppColors.lightColor
                            ..style = PaintingStyle.stroke,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
