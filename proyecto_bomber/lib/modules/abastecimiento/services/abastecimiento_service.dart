import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/abastecimiento/model/abast/abastecimiento.dart';
import 'package:bomber/modules/abastecimiento/repositories/abastecimiento_repository.dart';

class AbastecimientoService {
  final AbastecimientoRepository _repository;

  AbastecimientoService(this._repository);

  Future<List<Abastecimiento>> lista() async {
    try {
      return await _repository.lista();
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar abastecimiento');
    }
  }

  Future<Abastecimiento> save(Abastecimiento abastecimiento) async {
    try {
      return await _repository.save(abastecimiento);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar la abastecimiento',
      );
    }
  }

  Future<Abastecimiento> actualizar(Abastecimiento abastecimiento) async {
    try {
      return await _repository.actualizar(abastecimiento);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar la abastecimiento',
      );
    }
  }

  Future<void> eliminar(int id) async {
    try {
      return await _repository.eliminar(id);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al eliminar la abastecimiento',
      );
    }
  }

    Future<Uint8List?> reporteAbastecimiento(String desde, String hasta) async {
    try {
      final response = await _repository.reporteAbastecimiento(desde, hasta);
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
