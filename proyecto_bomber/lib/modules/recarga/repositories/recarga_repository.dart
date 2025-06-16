import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/recarga/model/recarga.dart';

class RecargaRepository {
  final RestClient _restClient;
  RecargaRepository(this._restClient);

  Future<Recarga> save(Recarga recarga) async {
    try {
      final response = await _restClient.post(
        '/recargas/insertar',
        data: recarga.toJson(),
      );
      return Recarga.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<Recarga> actualizar(Recarga recarga) async {
    try {
      final response = await _restClient.put(
        '/recargas/actualizar/${recarga.id}',
        data: recarga.toJson(), //Envia el objeto Recarga como JSON
      );
      return Recarga.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<List<Recarga>> lista() async {
    try {
      List<Recarga> list = [];
      final response = await _restClient.get('/recargas/listar');
      list = response.data.map<Recarga>((e) => Recarga.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await _restClient.delete('/recargas/eliminar/$id');
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<RestClientResponse> reporteRecarga(String desde, String hasta) async {
    return _restClient
        .get(
          '/recargas/reporte',
          queryParameters: {
            'fechaInicioString': desde,
            'fechaFinalString': hasta,
          },
        )
        .then((response) {
          return response;
        })
        .catchError((onError) {
          return onError;
        });
  }
}
