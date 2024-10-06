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
    return SlideInDown(
      duration: const Duration(milliseconds: 300),
      from: 30,
      child: Column(
        children: [
          ClipPath(
            clipper: CustomTriangleClipper(isLeft: isLeft),
            child: Container(
              width: 125,
              height: 60,
              padding: AppSpacings.s2All,
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
              child: Padding(
                padding: AppSpacings.s10Top,
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
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  final bool isLeft;

  CustomTriangleClipper({super.reclip, required this.isLeft});
  @override
  Path getClip(Size size) {
    final path = Path();
    if (isLeft) {
      path.moveTo(0, 15);
      path.lineTo(0, 0);
      path.lineTo(15, 15);
      // path.lineTo(25, 0);
    } else {
      path.moveTo(size.width, 15);
      path.lineTo(size.width, 0);
      path.lineTo(size.width - 15, 15);
    }
    if (isLeft) {
      path.lineTo(size.width, 15);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else {
      path.lineTo(0, 15);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    // path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
