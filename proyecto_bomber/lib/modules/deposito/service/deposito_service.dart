import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/deposito/repositories/deposito_respository.dart';
import 'package:flutter/material.dart';

class DepositoService {
  final DepositoRespository _repository;

  DepositoService(this._repository);

  Future<List<Deposito>> lista() async {
    try {
      return await _repository.lista();
    } on RepositoryException catch (e) {
      throw ServiceException(message: e.message ?? 'Error al buscar depositos');
    }
  }

  Future<Deposito> save(Deposito deposito) async {
    try {
      return await _repository.save(deposito);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el deposito',
      );
    }
  }

  Future<Deposito> actualizar(Deposito deposito) async {
    try {
      return await _repository.actualizar(deposito);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al guardar el deposito',
      );
    }
  }

    Future<Uint8List?> reporteDepositos(double? capMin, double? capMax) async {
  capMin ??= 0;
  capMax ??= double.maxFinite;

  try {
    final response = await _repository.reporteDepositos(capMin, capMax);
    
    if (response.statusCode != 200) {
      debugPrint('Error en la respuesta: ${response.statusCode}');
      return null;
    }
    
    try {
      return base64Decode(response.data);
    } catch (e) {
      debugPrint('Error decodificando base64: $e');
      return null;
    }
  } catch (e) {
    debugPrint('Error en reporteDepositos: $e');
    return null;
  }
}

  Future<void> eliminar(int id) async {
    try {
      return await _repository.eliminar(id);
    } on RepositoryException catch (e) {
      throw ServiceException(
        message: e.message ?? 'Error al eliminar el deposito',
      );
    }
  }
}
