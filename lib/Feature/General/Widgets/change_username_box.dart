import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_gold_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class ChangeUsernameBox extends StatelessWidget {
  ChangeUsernameBox({
    super.key,
    required this.username,
    required this.onChange,
  });

  final String username;
  final Function(String) onChange;
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = username;
    return ListView(
      children: [
        Padding(
          padding: AppSpacings.s20Horizental10Vertical,
          child: Text(
            AppTexts.changeUsernamePrice.tr,
            style: const TextStyle(
              color: AppColors.lightColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: AppSpacings.s20All,
          child: GlobalInputBox(
            label: AppTexts.enterUsername,
            controller: usernameController,
            textDirection: TextDirection.ltr,
            maxLength: 30,
            // onlyEnglishLetters: true,
          ),
        ),
        Padding(
          padding: AppSpacings.s40All,
          child: GlobalGoldButtonWidget(
            onTap:()=> onChange(usernameController.text),
            goldCount: 75,
            text: AppTexts.change.tr,
          ),
        ),
      ],
    );
  }
}
