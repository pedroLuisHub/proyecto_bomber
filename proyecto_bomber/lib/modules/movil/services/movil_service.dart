import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/movil/repositories/movil_repository.dart';

class MovilService {
  final MovilRepository _repository;

  MovilService(this._repository);

  Future<List<Movil>> lista(String condition) async {
    try {

      return await _repository.lista(condition);
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar moviles');
    }
  }

  Future<Movil> save(Movil movil) async {
    try {
      return await _repository.save(movil);
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al guardar el movil');
    }
  }

  Future<Movil> actualizar(Movil movil) async {
    try {
      return await _repository.actualizar(movil);
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al guardar el movil');
    }
  }

    Future<Uint8List?> reporteMoviles(String desde, String hasta) async {
    if(desde.isEmpty){
      desde = 'a';
    }
    if(hasta.isEmpty){
      hasta = 'z';
    }
    try {
      final response = await _repository.reporteMoviles(desde, hasta);
      Uint8List? resultPDF;
      if (response.statusCode == 200) {
        resultPDF = base64Decode(response.data);
      }
      return resultPDF;
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al generar reporte');
    }
  }

  Future<void> eliminar(int id) async {
    try {
      return await _repository.eliminar(id);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al eliminar el movil',
      );
    }
  }
}
