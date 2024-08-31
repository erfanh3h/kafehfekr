import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:flutter/material.dart';

class GlobalFadeInOutTextBox extends StatefulWidget {
  const GlobalFadeInOutTextBox({
    super.key,
    required this.text,
    this.fontSize = 16,
  });

  final String text;
  final double fontSize;
  @override
  State<GlobalFadeInOutTextBox> createState() => _GlobalFadeInOutTextBoxState();
}

class _GlobalFadeInOutTextBoxState extends State<GlobalFadeInOutTextBox>
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
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          foreground: Paint()
            ..strokeWidth = 1.5
            ..color = AppColors.lightColor
            ..style = PaintingStyle.stroke,
        ),
      ),
    );
  }
}
