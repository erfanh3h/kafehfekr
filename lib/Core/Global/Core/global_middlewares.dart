import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    if (Get.find<GlobalController>().token == null) {
      DialogComponent().showToast(label: AppTexts.mostLoginrFirst.tr);
      return RouteDecoder.fromRoute(AppRoutes.auth);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    // if (AuthService.to.isLoggedInValue) {
    //   //NEVER navigate to auth screen, when user is already authed
    //   return null;

    //   //OR redirect user to another screen
    //   //return RouteDecoder.fromRoute(Routes.PROFILE);
    // }
    return await super.redirectDelegate(route);
  }
}
