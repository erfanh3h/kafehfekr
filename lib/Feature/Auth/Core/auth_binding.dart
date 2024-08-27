import 'package:kafehfekr/Feature/Auth/Controllers/auth_controller.dart';
import 'package:kafehfekr/Feature/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';

class AuthBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<AuthRepository>(() => AuthRepositoryImp(), fenix: true),
        Get.lazyPut<AuthController>(
          () => AuthController(authRepo: Get.find<AuthRepository>()),
          fenix: true,
        ),
      ];
}
