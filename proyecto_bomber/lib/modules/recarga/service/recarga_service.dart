import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/recarga/model/recarga.dart';
import 'package:bomber/modules/recarga/repositories/recarga_repository.dart';

class RecargaService {
  final RecargaRepository _repository;

  RecargaService(this._repository);

  Future<List<Recarga>> lista() async {
    try {
      return await _repository.lista();
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar recarga');
    }
  }

  Future<Recarga> save(Recarga recarga) async {
    try {
      return await _repository.save(recarga);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar la recarga',
      );
    }
  }

  Future<Recarga> actualizar(Recarga recarga) async {
    try {
      return await _repository.actualizar(recarga);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar la recarga',
      );
    }
  }

  Future<void> eliminar(int id) async {
    try {
      return await _repository.eliminar(id);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al eliminar la recarga',
      );
    }
  }

  Future<Uint8List?> reporteRecarga(String desde, String hasta) async {
    try {
      final response = await _repository.reporteRecarga(desde, hasta);
      Uint8List? resultPDF;
      if (response.statusCode == 200) {
        resultPDF = base64Decode(response.data);
      }
      return resultPDF;
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al generar reporte');
    }
  }
}
