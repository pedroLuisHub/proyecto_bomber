import 'package:bomber/core/components/api/host_name.dart';
import 'package:bomber/core/components/dio/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';

import '../exceptions/rest_client_exception.dart';
import 'i_rest_client.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/no_auth_interceptor.dart';
import 'rest_client_response.dart';

class RestClient implements IRestClient {
  late Dio _dio;

  BaseOptions _baseOptions = BaseOptions(
    baseUrl: Hostname.instance.ip,
    followRedirects: false,
    connectTimeout: const Duration(milliseconds: 120000),
    receiveTimeout: const Duration(milliseconds: 1200000),
  );

  RestClient() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.addAll([
      NoAuthInterceptor(),
      ErrorInterceptor(),
      //   TimeExecutionInterceptor(),
      //    DateInterceptor(),
      // RetryOnConnectionChangeInterceptor(
      //   requestRetrier: ConnectivityInterceptor(
      //     dio: _dio,
      //     connectivity: Connectivity(),
      //   ),
      // ),
    ]);
  }

  RestClient.auth() {
    _dio = Dio(_baseOptions);

    _dio.interceptors.addAll([ErrorInterceptor(), AuthInterceptor()]);
  }

  updateURL() {
    _baseOptions = BaseOptions(
      baseUrl: Hostname.instance.ip,
      followRedirects: false,
      connectTimeout: const Duration(milliseconds: 120000),
      receiveTimeout: const Duration(milliseconds: 1200000),
    );
    _dio.options = _baseOptions;
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: 'Sin conexion con internet"',
          statusCode: 401,
        );
      }

      final responde = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: "Sin conexion con internet",
          statusCode: 401,
        );
      }
      final responde = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: "Sin conexion con internet",
          statusCode: 401,
        );
      }
      final responde = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: "Sin conexion con internet",
          statusCode: 401,
        );
      }
      final responde = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: "Sin conexion con internet",
          statusCode: 401,
        );
      }
      final responde = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      bool hasConnection = await validateInternetConnection();
      if (!hasConnection) {
        throw RestClientException(
          statusMessage: "Sin conexion con internet",
          statusCode: 401,
        );
      }
      final responde = await _dio.request(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _sucessManager<T>(responde);
    } on DioException catch (e) {
      return _errorManager(e);
    }
  }

  _errorManager(e) {
    if (e.error == null) {
      throw RestClientException(
        statusMessage: e.message,
        statusCode: e.response?.statusCode,
        error: e,
      );
    }
    if (e.error is String) {
      if (e != null && e.error.toString().contains("500")) {
        throw RestClientException(
          statusMessage: "Error desconocido",
          statusCode: e.response?.statusCode,
          error: e,
        );
      }

      throw RestClientException(
        statusMessage: e?.error ?? "Error desconocido",
        statusCode: e.response?.statusCode,
        error: e,
      );
    } else {
      throw RestClientException(
        statusMessage: e?.error.statusMessage ?? e?.error.toString(),
        statusCode: e?.response?.statusCode ?? 503,
        error: e,
      );
    }
  }

  RestClientResponse<T> _sucessManager<T>(Response<dynamic> response) {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Future<bool> validateInternetConnection() async {
    return true;
  }
}
