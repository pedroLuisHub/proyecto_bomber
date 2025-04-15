import 'dart:developer';

import 'package:dio/dio.dart';

import '../../exceptions/rest_client_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error != null) {
      if (err.error.toString().contains("SocketException")) {
        throw RestClientException(
            statusMessage: "Sin conexion con el servidor",
            statusCode: 0,
            error: err.error);
      }
    }
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
