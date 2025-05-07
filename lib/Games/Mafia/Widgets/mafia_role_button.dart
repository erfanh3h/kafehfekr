import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class MafiaButton extends StatelessWidget {
  const MafiaButton({
    super.key,
    this.onTap,
    required this.text,
    this.icon = Icons.add,
  });

  final Function(String)? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(text);
        }
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 11,
              ),
            ),
            Icon(
              icon,
              color: AppColors.lightColor,
            ),
          ],
        ),
      ),
    );
  }
}
