import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/date_actions.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/message_model.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.data,
  });

  final MessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: AppSpacings.s10Horizental,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => FunctionsLibraryClass.showUserData(data.userId),
                  child: Text(
                    data.username,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 15,
                      fontFamily: FontFamilies.playPen,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  DialogComponent()
                      .showToast(label: 'گزارش پیام نادرست ثبت شد');
                },
                child: const Icon(
                  Icons.report_gmailerrorred_outlined,
                  size: 20,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                DateActionsComponent.dateTimeToHourMin(data.time),
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 12,
                  fontFamily: FontFamilies.playPen,
                ),
                textDirection: TextDirection.ltr,
              )
            ],
          ),
        ),
        Card(
          child: Container(
            padding: AppSpacings.s10All,
            width: double.maxFinite,
            child: Text(
              data.content,
              style: const TextStyle(color: AppColors.lightColor, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
