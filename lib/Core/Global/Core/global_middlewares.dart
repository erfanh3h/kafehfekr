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

class EnsureNetworkIsOnMiddleware extends GetMiddleware {
  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    if (Get.find<GlobalController>().isNoNetwork.value) {
      DialogComponent().showToast(label: AppTexts.serverError.tr);
      return null;
    }
    return await super.redirectDelegate(route);
  }
}
