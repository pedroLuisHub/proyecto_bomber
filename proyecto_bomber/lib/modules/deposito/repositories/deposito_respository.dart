import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/deposito/pages/deposito_reporte.dart';

class DepositoRespository {
  final RestClient _restClient;
  DepositoRespository(this._restClient);

  Future<Deposito> save(Deposito deposito) async {
    try {
      final response = await _restClient.post(
        '/depositos/insertar',
        data: deposito.toJson(),
      );
      return Deposito.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<Deposito> actualizar(Deposito deposito) async {
    try {
      final response = await _restClient.put(
        '/depositos/actualizar/${deposito.id}',
        data: deposito.toJson(), //Envia el objeto Deposito como JSON
      );
      return Deposito.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<List<Deposito>> lista() async {
    try {
      List<Deposito> list = [];
      final response = await _restClient.get('/depositos/lista');
      list = response.data.map<Deposito>((e) => Deposito.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await _restClient.delete('/depositos/eliminar/$id');
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<RestClientResponse> reporteDepositos(double capMin, double capMax) async {
    return _restClient
        .get(
          '/depositos/reporte',
          queryParameters: {'numMin': capMin, 'numMax': capMax},
        )
        .then((response) {
          return response;
        })
        .catchError((onError) {
          return onError;
        });
  }
}