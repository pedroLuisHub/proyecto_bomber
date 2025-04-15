import 'package:dio/dio.dart';

import 'repository_exception.dart';
import 'rest_client_exception.dart';
import 'service_exception.dart';

class ExceptionUtils {
  static String getExceptionMessage(dynamic exception) {
    switch (exception.runtimeType) {
      case RestClientException:
        return exception.statusMessage ?? "Error desconocido";
      case RepositoryException:
        return exception.message ?? "Error desconocido";
      case ServiceException:
        return exception.message ?? "Error desconocido";
      case DioException:
        return exception.toString();
      case Exception:
        return exception.toString();
      case Error:
        return exception.toString();
      default:
        return exception.toString();
    }
  }
}
