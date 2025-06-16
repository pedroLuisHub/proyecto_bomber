import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/movil/model/movil.dart';

class MovilRepository {
  final RestClient _restClient;
  MovilRepository(this._restClient);

  Future<Movil> save(Movil movil) async {
    try {
      final response = await _restClient.post(
        '/moviles/insertar',
        data: movil.toJson(),
      );
      return Movil.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<Movil> actualizar(Movil movil) async {
    try {
      final response = await _restClient.put(
        '/moviles/actualizar/${movil.id}',
        data: movil.toJson(), //Envia el objeto Movil como JSON
      );
      return Movil.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await _restClient.delete('/moviles/eliminar/$id');
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<List<Movil>> lista(String condition) async {
    try {
      List<Movil> list = [];
      final response = await _restClient.get(
        '/moviles/lista',
        queryParameters: {'condition': condition},
      );
      list = response.data.map<Movil>((e) => Movil.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<RestClientResponse> reporteMoviles(String desde, String hasta) async {
    return _restClient
        .get(
          '/moviles/reporte',
          queryParameters: {'desde': desde, 'hasta': hasta},
        )
        .then((response) {
          return response;
        })
        .catchError((onError) {
          return onError;
        });
  }
}
