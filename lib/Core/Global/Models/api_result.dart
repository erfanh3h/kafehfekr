import 'package:kafehfekr/Core/Network/network_exceptions.dart';

class ApiResult<T> {
  T? resultData;
  NetworkExceptions? errorData;

  ApiResult({
    this.resultData,
    this.errorData,
  });
  factory ApiResult.success({required T data}) {
    return ApiResult(resultData: data);
  }
  factory ApiResult.failure({required NetworkExceptions error}) {
    return ApiResult(errorData: error);
  }
}
