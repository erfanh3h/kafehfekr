import 'package:flutter/material.dart';

class GlobalFocusWidget extends StatefulWidget {
  const GlobalFocusWidget({
    super.key,
    required this.child,
    this.baseScale = 1.0,
    this.onTap,
  });

  final double baseScale;
  final Widget child;
  final Function()? onTap;

  @override
  State<GlobalFocusWidget> createState() => _GlobalFocusWidgetState();
}

class _GlobalFocusWidgetState extends State<GlobalFocusWidget> {
  double baseHover = 1;

  @override
  void initState() {
    baseHover = widget.baseScale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) async {
        if (value) {
          for (var i = 0; i < 20; i++) {
            await Future.delayed(const Duration(milliseconds: 1));
            setState(() {
              baseHover += .01;
            });
          }
        } else {
          for (var i = 0; i < 20; i++) {
            await Future.delayed(const Duration(milliseconds: 1));
            setState(() {
              baseHover -= .01;
            });
          }
        }
      },
      onTap: widget.onTap,
      child: Transform.scale(scale: baseHover, child: widget.child),
    );
  }
}
