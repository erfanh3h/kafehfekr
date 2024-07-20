import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/peace_model.dart';

class TicTacToeButton extends StatelessWidget {
  const TicTacToeButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final PeaceModel peaceData;
  final Function(PeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
