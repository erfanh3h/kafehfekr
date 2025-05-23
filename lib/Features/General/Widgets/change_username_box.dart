import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';

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
    return GlobalFrameWrapper(
      frame: AppImages.dialog,
      height: 200,
      padding: AppSpacings.s20Vertical40Horizental,
      child: Column(
        children: [
          // Padding(
          //   padding: AppSpacings.s20Horizental10Vertical,
          //   child: Text(
          //     AppTexts.changeUsernamePrice.tr,
          //     style: const TextStyle(
          //       color: AppColors.lightColor,
          //       fontSize: 20,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          const Spacer(),
          GlobalInputBox(
            label: AppTexts.enterUsername,
            controller: usernameController,
            textDirection: TextDirection.ltr,
            maxLength: 30,
            // onlyEnglishLetters: true,
          ),
          const Spacer(),
          GlobalFrameWrapper(
            frame: AppImages.check,
            child: InkWell(
              onTap: () {
                onChange(usernameController.text);
              },
              child: const SizedBox(width: 35, height: 35),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
