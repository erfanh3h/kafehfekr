import 'package:kafehfekr/Games/Risk/Controllers/risk_controller.dart';
import 'package:refreshed/refreshed.dart';

class RiskBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<RiskController>(() => RiskController(), fenix: true),
      ];
}
