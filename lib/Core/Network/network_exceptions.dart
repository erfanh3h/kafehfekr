class NetworkExceptions {
  int? statusCode;
  String? result;
  NetworkExceptions({
    this.statusCode,
    this.result,
  });
  factory NetworkExceptions.fromResult(int statusCode, String result) {
    return NetworkExceptions(result: result, statusCode: statusCode);
  }
  // It will use on Dio
  // static NetworkExceptions handleResponse(final error) {
  // switch (error.response.statusCode) {
  // case 400:
  // case 401:
  // case 403:
  //   return const NetworkExceptions.unauthorizedRequest('');
  // case 404:
  //   return const NetworkExceptions.notFound('Not found');
  // case 409:
  //   return const NetworkExceptions.conflict();
  // case 408:
  //   return const NetworkExceptions.requestTimeout();
  // case 500:
  //   return const NetworkExceptions.internalServerError();
  // case 503:
  //   return const NetworkExceptions.serviceUnavailable();
  // default:
  //   return const NetworkExceptions.defaultError('');
  // return NetworkExceptions.defaultError(
  //   'Received invalid status code: $responseCode',
  // );
  // }
  // }

}
