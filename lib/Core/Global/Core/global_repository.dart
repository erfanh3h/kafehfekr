import 'package:kafehfekr/Core/Global/Components/storage.dart';

abstract class GlobalRepository {
  Future<String?> getDataFromStorage({required String key});

  Future<void> setDataOnStorage(
      {required final String key, required final String value});

  Future<String?> removeDataFromStorage({required String key});

  Future<void> logoutRemoveData();
}

class GlobalRepositoryImp extends GlobalRepository {
  @override
  Future<String?> getDataFromStorage({required String key}) async {
    return await StorageComponent.getData(key);
  }

  @override
  Future<void> setDataOnStorage(
      {required final String key, required final String value}) async {
    await StorageComponent.setData(key, value);
  }

  @override
  Future<String?> removeDataFromStorage({required String key}) async {
    return await StorageComponent.removeData(key);
  }

  @override
  Future<void> logoutRemoveData() async {
    await StorageComponent.clearData();
  }
}
