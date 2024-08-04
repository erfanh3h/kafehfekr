import 'package:flutter/material.dart';

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
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(5),
        //   color: Colors.white.withOpacity(0.5),
        // ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
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
      // onDragCompleted: () => print("Ss"),
      onDraggableCanceled: (_, __) {
        // print('Drag Canceled');
      },
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
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
