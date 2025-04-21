import 'package:kafehfekr/Core/Global/Components/storage.dart';
import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Global/Models/config_model.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/General/Models/user_history_model.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';

class GlobalRepository with RestClient {
  Future<ApiResult<bool>> changeProfile({required int image}) async {
    bool data = false;
    var response =
        await sendData(ServerRoutes.changeImage, data: {'image': image});
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  Future<ApiResult<bool>> changeUsername({required String username}) async {
    bool data = false;
    var response = await sendData(ServerRoutes.changeUsername,
        data: {'username': username});
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  Future<ApiResult<(UserModel?, UserHistoryModel?)>> getUserData(
      {required String userId}) async {
    var response = await getData(ServerRoutes.userData(userId));
    NetworkExceptions? errorData;
    UserModel? user;
    UserHistoryModel? userHistory;
    if (response.resultData != null) {
      user = UserModel.fromJson(response.resultData['result']['data']);
      userHistory =
          UserHistoryModel.fromJson(response.resultData['result']['history']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<(UserModel?, UserHistoryModel?)>(
        resultData: (user, userHistory), errorData: errorData);
    return result;
  }

  Future<ApiResult<UserModel?>> getMyData() async {
    var response = await getData(ServerRoutes.myData);
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

  Future<ApiResult<ConfigModel?>> getConfigData() async {
    var response = await getData(ServerRoutes.configData, needToken: false);
    NetworkExceptions? errorData;
    ConfigModel? config;
    if (response.resultData != null) {
      config = ConfigModel.fromJson(response.resultData['result']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<ConfigModel?>(
      resultData: config,
      errorData: errorData,
    );
    return result;
  }

  Future<ApiResult<UserHistoryModel?>> getMyHistoryData() async {
    var response = await getData(ServerRoutes.myHistory);
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

  Future<String?> getDataFromStorage({required String key}) async {
    return await StorageComponent.getData(key);
  }

  Future<void> setDataOnStorage(
      {required final String key, required final String value}) async {
    await StorageComponent.setData(key, value);
  }

  Future<String?> removeDataFromStorage({required String key}) async {
    return await StorageComponent.removeData(key);
  }

  Future<void> logoutRemoveData() async {
    await StorageComponent.clearData();
  }
}
