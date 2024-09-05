import 'package:kafehfekr/Core/Global/Components/storage.dart';
import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Global/Models/config_model.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_history_model.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';

abstract class GlobalRepository {
  Future<ApiResult<UserModel?>> getMyData();
  Future<ApiResult<ConfigModel?>> getConfigData();
  Future<ApiResult<UserHistoryModel?>> getMyHistoryData();

  Future<ApiResult<bool>> changeProfile({required int image});

  Future<String?> getDataFromStorage({required String key});

  Future<void> setDataOnStorage(
      {required final String key, required final String value});

  Future<String?> removeDataFromStorage({required String key});

  Future<void> logoutRemoveData();
}

class GlobalRepositoryImp extends GlobalRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<bool>> changeProfile({required int image}) async {
    bool data = false;
    var response = await _restClient
        .sendData(ServerRoutes.changeImage, data: {'image': image});
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<UserModel?>> getMyData() async {
    var response = await _restClient.getData(ServerRoutes.myData);
    NetworkExceptions? errorData;
    UserModel? user;
    if (response.resultData != null) {
      user = UserModel.fromJson(response.resultData['result']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<UserModel?>(resultData: user, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<ConfigModel>> getConfigData() async {
    var response =
        await _restClient.getData(ServerRoutes.configData, needToken: false);
    NetworkExceptions? errorData;
    ConfigModel? config;
    if (response.resultData != null) {
      config = ConfigModel.fromJson(response.resultData['result']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<ConfigModel>(
      resultData: config ?? ConfigModel(),
      errorData: errorData,
    );
    return result;
  }

  @override
  Future<ApiResult<UserHistoryModel?>> getMyHistoryData() async {
    var response = await _restClient.getData(ServerRoutes.myHistory);
    NetworkExceptions? errorData;
    UserHistoryModel? user;
    if (response.resultData != null) {
      user = UserHistoryModel.fromJson(response.resultData['result']);
    } else {
      errorData = response.errorData;
    }
    var result =
        ApiResult<UserHistoryModel?>(resultData: user, errorData: errorData);
    return result;
  }

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
