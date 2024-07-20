import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

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
        padding: AppSpacings.s15All,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        // child: Image.asset(
        //   GeneralIcons.circle1,
        //   color: Colors.blue,
        // ),
      ),
    );
  }
}
