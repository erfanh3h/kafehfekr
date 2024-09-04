import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';

abstract class AuthRepository {
  Future<ApiResult<bool>> enterUser({required String phone});
  Future<ApiResult<(UserModel?, String)>> enterCode({
    required String phone,
    required String code,
  });

  Future<ApiResult<bool>> completeUser({
    required String phone,
    required String username,
  });
}

class AuthRepositoryImp extends AuthRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<bool>> enterUser({required String phone}) async {
    bool data = false;
    var response = await _restClient.sendData(ServerRoutes.enterUser,
        needToken: false, data: {'phone': phone});
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
  Future<ApiResult<(UserModel?, String)>> enterCode(
      {required String phone, required String code}) async {
    var response = await _restClient
        .sendData(ServerRoutes.enterCode, needToken: false, data: {
      'phone': phone,
      'code': code,
    });
    NetworkExceptions? errorData;
    String token = "";
    UserModel? user;
    if (response.resultData != null) {
      user = UserModel.fromJson(response.resultData['user_data']);
      token = response.resultData['token'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<(UserModel?, String)>(
        resultData: (user, token), errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> completeUser(
      {required String phone, required String username}) async {
    bool data = false;
    var response = await _restClient.sendData(ServerRoutes.completeUserData,
        data: {'phone': phone, 'username': username, 'device_id': "device"});
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }
}
