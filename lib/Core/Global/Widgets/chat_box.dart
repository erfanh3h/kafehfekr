import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.isLeft,
    required this.index,
  });

  final bool isLeft;
  final int index;
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        width: double.maxFinite,
        height: 60,
        margin: AppSpacings.s20Horizental5Vertical,
        child: Row(
          mainAxisAlignment:
              isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                // color: AppColors.goldenColor2,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(isLeft ? 200 : 50, 212, 133, 126),
                    Color.fromARGB(isLeft ? 50 : 200, 214, 172, 168),
                  ],
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  chats[index],
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
