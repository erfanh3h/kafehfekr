import 'package:flutter/material.dart';

class TenDraggableOperatorWidget extends StatelessWidget {
  const TenDraggableOperatorWidget({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: value,
      feedback: SizedBox(
        width: 50,
        height: 50,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(5),
        //   color: Colors.white.withOpacity(0.5),
        // ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.35),
        ),
        width: 50,
        height: 50,
      ),
      // onDragCompleted: () => print("Ss"),
      onDraggableCanceled: (_, __) {
        // print('Drag Canceled');
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.25),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
