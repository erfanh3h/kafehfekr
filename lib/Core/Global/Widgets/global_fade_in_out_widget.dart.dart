import 'package:flutter/material.dart';

class GlobalFadeInOutWidget extends StatefulWidget {
  const GlobalFadeInOutWidget({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  State<GlobalFadeInOutWidget> createState() => _GlobalFadeInOutWidgetState();
}

class _GlobalFadeInOutWidgetState extends State<GlobalFadeInOutWidget>
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
        Future.delayed(const Duration(seconds: 3)).then((_) {
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
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: widget.child,
    );
  }
}
