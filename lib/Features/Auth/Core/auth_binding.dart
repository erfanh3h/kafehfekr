import 'package:kafehfekr/Features/Auth/Controllers/auth_controller.dart';
import 'package:refreshed/refreshed.dart';

class AuthBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true),
      ];
}
