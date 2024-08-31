import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_text_widget.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GlobalWaitWidget extends StatelessWidget {
  const GlobalWaitWidget({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return GlobalFadeInOutTextBox(
      text: text ?? AppTexts.wait.tr,
      fontSize: 18,
    );
  }
}
