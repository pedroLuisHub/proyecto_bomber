import 'package:bomber/core/components/dio/rest_client.dart';
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

  Future<List<Ciudadano>> lista() async {
    try {
      List<Ciudadano> list = [];
      final response = await _restClient.get('/ciudadanos/lista');
      list = response.data.map<dynamic>((e) => e).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }
}
