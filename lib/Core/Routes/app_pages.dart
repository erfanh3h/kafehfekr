import 'package:kafehfekr/Core/Global/Core/global_binding.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/Game/Pages/game_board_page.dart';
import 'package:refreshed/refreshed.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    // GetPage(
    //   name: AppRoutes.splash,
    //   page: SplashPage.new,
    //   binding: GlobalBinding(),
    // ),
    GetPage(
      name: AppRoutes.main,
      page: GameBoardPage.new,
      binding: GlobalBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.days,
    //   page: DaysPage.new,
    //   binding: DaysPageBinding(),
    //   preventDuplicates: false,
    // ),
  ];
}
