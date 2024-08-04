import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';

class TenDraggableNumberWidget extends StatelessWidget {
  const TenDraggableNumberWidget({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: value,
      feedback: SizedBox(
        width: 50,
        height: 50,
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: FontFamilies.dastnevis,
              decoration: TextDecoration.none,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.4),
        ),
        width: 50,
        height: 50,
      ),
      onDraggableCanceled: (_, __) {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.5),
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: FontFamilies.dastnevis,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
