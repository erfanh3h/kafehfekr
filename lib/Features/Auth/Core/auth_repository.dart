import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Models/api_result.dart';
import 'package:kafehfekr/Core/Network/network_exceptions.dart';
import 'package:kafehfekr/Core/Network/rest_client.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Features/Auth/Models/user_model.dart';

class AuthRepository with RestClient {
  Future<ApiResult<bool>> enterUser({required String phone}) async {
    bool data = false;
    var response = await sendData(ServerRoutes.enterUser,
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

  Future<ApiResult<(UserModel?, String)>> enterCode(
      {required String phone, required String code}) async {
    final deviceId = await FunctionsLibraryClass.getDeviceId();
    var response =
        await sendData(ServerRoutes.enterCode, needToken: false, data: {
      'phone': phone,
      'code': code,
      'device_id': deviceId,
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

  Future<ApiResult<bool>> completeUser({
    required String phone,
    required String username,
    required String rId,
  }) async {
    bool data = false;
    var response = await sendData(ServerRoutes.completeUserData, data: {
      'phone': phone,
      'username': username,
      'rep_id': rId,
    });
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
