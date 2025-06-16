import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';

class CiudadanoRepository {
  final RestClient _restClient;
  CiudadanoRepository(this._restClient);

  Future<Ciudadano> save(Ciudadano ciudadano) async {
    try {
      final response = await _restClient.post(
        '/ciudadanos/insertar',
        data: ciudadano.toJson(),
      );
      return Ciudadano.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<Ciudadano> actualizar(Ciudadano ciudadano) async {
    try {
      final response = await _restClient.put(
        '/ciudadanos/actualizar/${ciudadano.id}',
        data: ciudadano.toJson(), //Envia el objeto Ciudadano como JSON
      );
      return Ciudadano.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<List<Ciudadano>> lista(String condition) async {
    try {
      List<Ciudadano> list = [];
      final response = await _restClient.get('/ciudadanos/lista',
        queryParameters: {'condition': condition},);
      list = response.data.map<Ciudadano>((e) => Ciudadano.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<void> eliminar(int id) async {
  try {
    await _restClient.delete('/ciudadanos/eliminar/$id');
  } on Exception catch (e) {
    throw RepositoryException.fromException(e);
  }
}

  Future<RestClientResponse> reporteCiudadanos(String desde, String hasta) async {
    return _restClient
        .get(
          '/ciudadanos/reporte',
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
