import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:bomber/modules/ciudadano/repositories/ciudadano_repository.dart';

class CiudadanoService {
  final CiudadanoRepository _repository;

  CiudadanoService(this._repository);

    Future<List<Ciudadano>> lista(String condition) async {
    try {
      return await _repository.lista(condition);
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar ciudadanos');
    }
  }

  Future<Ciudadano> save(Ciudadano ciudadano) async {
    try {
      return await _repository.save(ciudadano);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el ciudadano',
      );
    }
  }

  Future<Ciudadano> actualizar(Ciudadano ciudadano) async {
    try {
      return await _repository.actualizar(ciudadano);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el ciudadano',
      );
    }
  }

    Future<Uint8List?> reporteCiudadanos(String desde, String hasta) async {
    if(desde.isEmpty){
      desde = 'a';
    }
    if(hasta.isEmpty){
      hasta = 'z';
    }
    try {
      final response = await _repository.reporteCiudadanos(desde, hasta);
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
        message: e.message ?? 'Error al eliminar el ciudadano',
      );
    }
  }
}