import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateController extends BaseController {
  Future<void> onTap() async {
    String link;
    if (marketType == MarketTypes.Bazaar) {
      link = ServerRoutes.bazaarLink;
    } else {
      link = ServerRoutes.myketLink;
    }
    final Uri url = Uri.parse(link);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
