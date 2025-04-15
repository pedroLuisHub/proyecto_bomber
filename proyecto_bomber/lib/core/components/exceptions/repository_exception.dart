import 'rest_client_exception.dart';

class RepositoryException implements Exception {
  String? message;
  int? code;
  RepositoryException(this.message, this.code);

  RepositoryException.fromException(Exception e) {
    if (e is RestClientException) {
      switch (e.statusCode) {
        case 404:
          message = 'No se encontro el recurso, favor de contactar al soporte';
          code = 404;
          return;
        case 500:
          message =
              'Error en el servidor, favor cerrar y volver a abrir o contacte al soporte';
          code = 500;
          return;
        default:
          message = e.statusMessage ?? "Error desconocido";
          code = e.statusCode;
          return;
      }
    }
    message = e.toString();
    code = 500;
  }

  @override
  String toString() {
    return " ${message ?? ''} -  ${code ?? ''}";
  }
}
