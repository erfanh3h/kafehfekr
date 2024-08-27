
abstract class AuthRepository {
  Future<void> login({required String phone});
}

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<void> login({required String phone}) async {}
}
