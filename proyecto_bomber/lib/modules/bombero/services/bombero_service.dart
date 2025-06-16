import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/repositories/bombero_repository.dart';

class BomberoService {
  final BomberoRepository _repository;

  BomberoService(this._repository);

  Future<List<Bombero>> lista(String condition) async {
    try {
      return await _repository.lista(condition);
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar bomberos');
    }
  }

  Future<Bombero> save(Bombero bombero) async {
    try {
      return await _repository.save(bombero);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el bombero',
      );
    }
  }

  Future<Bombero> actualizar(Bombero bombero) async {
    try {
      return await _repository.actualizar(bombero);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el bombero',
      );
    }
  }

  Future<Uint8List?> reporteBomberos(String desde, String hasta) async {
    if(desde.isEmpty){
      desde = 'a';
    }
    if(hasta.isEmpty){
      hasta = 'z';
    }
    try {
      final response = await _repository.reporteBomberos(desde, hasta);
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
        message: e.message ?? 'Error al eliminar el bombero',
      );
    }
  }
}
