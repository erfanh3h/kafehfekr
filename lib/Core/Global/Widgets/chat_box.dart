import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.chatData,
  });
  final (String, int) chatData;
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        width: double.maxFinite,
        // height: 60,
        margin: AppSpacings.s20Horizental5Vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatData.$1,
              style: const TextStyle(
                fontFamily: FontFamilies.hekayat,
                fontSize: 17,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                // color: AppColors.goldenColor2,
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(50, 212, 133, 126),
                    Color.fromARGB(200, 214, 172, 168),
                  ],
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  chats[chatData.$2],
                  style: const TextStyle(
                    fontFamily: FontFamilies.hekayat,
                    fontSize: 17,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
