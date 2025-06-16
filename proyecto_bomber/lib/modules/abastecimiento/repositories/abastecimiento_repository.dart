import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:bomber/core/components/dio/rest_client_response.dart';
import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/modules/abastecimiento/model/abast/abastecimiento.dart';

class AbastecimientoRepository {
  final RestClient _restClient;
  AbastecimientoRepository(this._restClient);

   Future<Abastecimiento> save(Abastecimiento abastecimiento) async {
    try {
      final response = await _restClient.post(
        '/abastecimientos/insertar',
        data: abastecimiento.toJson(),
      );
      return Abastecimiento.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<Abastecimiento> actualizar(Abastecimiento abastecimiento) async {
    try {
      final response = await _restClient.put(
        '/abastecimientos/actualizar/${abastecimiento.id}',
        data: abastecimiento.toJson(), //Envia el objeto Abastecimiento como JSON
      );
      return Abastecimiento.fromJson(response.data);
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<List<Abastecimiento>> lista() async {
    try {
      List<Abastecimiento> list = [];
      final response = await _restClient.get('/abastecimientos/listar');
      list = response.data.map<Abastecimiento>((e) => Abastecimiento.fromJson(e)).toList();
      return list;
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<void> eliminar(int id) async {
    try {
      await _restClient.delete('/abastecimientos/eliminar/$id');
    } on Exception catch (e) {
      throw RepositoryException.fromException(e);
    }
  }

    Future<RestClientResponse> reporteAbastecimiento(String desde, String hasta) async {
    return _restClient
        .get(
          '/abastecimientos/reporte',
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