import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:refreshed/refreshed.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalInputBox extends StatefulWidget {
  const GlobalInputBox({
    super.key,
    required this.label,
    required this.controller,
    // this.onTapFunction,
    this.changeFunction,
    this.enable = true,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.hideContent = false,
    this.minLines = 1,
    this.maxLines = 8,
    this.mustFill = false,
    this.textDirection = TextDirection.rtl,
    this.validator,
    this.maxLength,
    this.textInputAction,
    this.onlyEnglishLetters = false,
    this.textAlign = TextAlign.center,
  });

  // hint of input box
  final String label;

  // change function that called when value changed
  final Function(String)? changeFunction;

  //controller of GlobalInputBox
  final TextEditingController? controller;

  // GlobalInputBox is enabled
  final bool enable;

  // input type
  final TextInputType textType;

  // is GlobalInputBox read only or not
  final bool readOnly;

  // min lines of GlobalInputBox
  final int minLines;

  // max lines of GlobalInputBox
  final int? maxLines;

  // this GlobalInputBox most have value
  final bool mustFill;

  // validator of input box
  final Function? validator;

  // max length of input box
  final int? maxLength;

  // text direction of input box
  final TextDirection textDirection;

// text direction of input box
  final TextAlign textAlign;

  // password mode
  final bool hideContent;

  final bool onlyEnglishLetters;

  final TextInputAction? textInputAction;

  @override
  GlobalInputBoxState createState() => GlobalInputBoxState();
}

class GlobalInputBoxState extends State<GlobalInputBox> {
  bool isTapped = false;

  Function? validator;
  @override
  void initState() {
    //this use for set default validator
    if (widget.validator != null) {
      validator = widget.validator;
    } else {
      validator = (value) {
        return null;
      };
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: context.theme.inputDecorationTheme.fillColor,
      ),
      child: Directionality(
        textDirection: widget.textDirection,
        child: FocusScope(
          onFocusChange: (final val) {
            setState(() {
              isTapped = val;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.hideContent,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            onChanged: widget.changeFunction,
            validator: (val) => validator!(val),
            maxLength: widget.maxLength,
            inputFormatters: widget.onlyEnglishLetters
                ? [
                    FilteringTextInputFormatter.deny(RegExp(r'[^\x00-\x7F]+')),
                  ]
                : [],
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: AppSpacings.s15All,
              hintText: widget.label,
              hintTextDirection: TextDirection.rtl,
              // hintStyle:
              //     Get.textTheme.bodySmall!.copyWith(color: AppColors.grey500),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            // cursorColor: widget.color,
            style: Get.textTheme.bodyLarge!
                .copyWith(fontFamily: FontFamilies.playPen),
            keyboardType: widget.textType,
            textInputAction: widget.textInputAction,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            textAlign: widget.textAlign,
          ),
        ),
      ),
    );
  }
}
