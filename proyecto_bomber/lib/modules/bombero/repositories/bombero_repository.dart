import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';

class BomberoRepository {
  final RestClient _restClient;
  BomberoRepository(this._restClient);

  Future<Bombero> save(Bombero bombero) async {
    try {
      final response = await _restClient.post(
        '/bomberos/insertar',
        data: bombero.toJson(),
      );
      return Bombero.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<Bombero> actualizar(Bombero bombero) async {
    try {
      final response = await _restClient.put(
        '/bomberos/actualizar/${bombero.id}',
        data: bombero.toJson(), //Envia el objeto Bombero como JSON
      );
      return Bombero.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await _restClient.delete('/bomberos/eliminar/$id');
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<List<Bombero>> lista(String condition) async {
    try {
      List<Bombero> list = [];
      final response = await _restClient.get(
        '/bomberos/lista',
        queryParameters: {'condition': condition},
      );
      list = response.data.map<Bombero>((e) => Bombero.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<RestClientResponse> reporteBomberos(String desde, String hasta) async {
    return _restClient
        .get(
          '/bomberos/reporte',
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
