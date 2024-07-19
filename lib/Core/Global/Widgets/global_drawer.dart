import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        // color: Color(0xFFE1E1E1),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: ListView(
                shrinkWrap: true,
                children: const [
                  // Container(
                  //   margin: const EdgeInsets.all(8.0),
                  //   width: 70,
                  //   height: 70,
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/Images/logo.jpg"),
                  //       fit: BoxFit.scaleDown,
                  //       // scale: 2.5,
                  //     ),
                  //     // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  //     color: Colors.white,
                  //   ),
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.abc,
                    ),
                    title: Text('s'),
                  ),
                  // DrawerItemRow(
                  //   icon: FlutterIcons.search,
                  //   label: 'جست‌وجوی خودرو',
                  //   navigate: Routes.homeScreen,
                  // ),
                  // DrawerItemRow(
                  //   icon: FlutterIcons.align_right,
                  //   label: 'لیست خودرو‌ها',
                  //   navigate: Routes.loginScreen,
                  // ),
                  // AppSession.token == ''
                  //     ? DrawerItemRow(
                  //         icon: FlutterIcons.align_right,
                  //         label: 'ورود',
                  //         navigate: Routes.loginScreen,
                  //       )
                  //     : ListView(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         children: [
                  //           DrawerItemRow(
                  //             icon: FlutterIcons.user,
                  //             label: 'حساب کاربری',
                  //             navigate: Routes.profileScreen,
                  //           ),
                  //           DrawerItemRow(
                  //             icon: FlutterIcons.doc_text,
                  //             label: 'رزروهای من',
                  //             navigate: Routes.myRentCarRequestScreen,
                  //             requeireVeryfy: true,
                  //           ),
                  //           DrawerItemRow(
                  //             icon: FlutterIcons.car_side,
                  //             label: 'خودروهای من',
                  //             navigate: Routes.myCarsScreen,
                  //             requeireVeryfy: true,
                  //           ),
                  //           DrawerItemRow(
                  //             icon: FlutterIcons.align_left,
                  //             label: 'رزروهای خودروی من',
                  //             navigate: Routes.myCarsRequestScreen,
                  //             requeireVeryfy: true,
                  //           ),
                  //         ],
                  //       )
                  // Spacer(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.support_agent, size: 30),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.entry),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class DrawerItemRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final String navigate;
//   final bool requeireVeryfy;

//   const DrawerItemRow({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.navigate,
//     this.requeireVeryfy = false,
//     this.value = '0',
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.back();
//         if (requeireVeryfy && !AppSession.userData!.verified!) {
//           showDialog(
//             context: context,
//             builder: (ctx) => GlobalAlertDialog(
//               title: 'خطا',
//               content: 'حساب کاربری شما تایید نشده است!',
//             ),
//           );
//         } else {
//           Navigator.of(context).pushNamed(navigate);
//         }
//       },
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Icon(
//                 icon,
//                 size: 6 * AppSession.deviceBlockSize,
//                 color: AppSession.mainFontColor,
//               ),
//               SizedBox(width: 2 * AppSession.deviceBlockSize),
//               Expanded(
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     color: AppSession.mainFontColor,
//                     fontSize: 5 * AppSession.deviceBlockSize,
//                     fontFamily: 'iranyekanlight',
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//               ),
//               // Spacer(),
//               value != '0'
//                   ? CircleAvatar(
//                       radius: AppSession.deviceBlockSize * 3,
//                       child: Text(
//                         value,
//                         style: TextStyle(
//                           fontFamily: 'montserrat',
//                           fontSize: AppSession.deviceBlockSize * 3,
//                         ),
//                       ),
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
