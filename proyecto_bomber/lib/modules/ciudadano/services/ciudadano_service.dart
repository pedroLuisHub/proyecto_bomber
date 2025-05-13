import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:bomber/modules/ciudadano/repositories/ciudadano_repository.dart';

class CiudadanoService {
  final CiudadanoRepository _repository;

  CiudadanoService(this._repository);

    Future<List<Ciudadano>> lista() async {
    try {
      return await _repository.lista();
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
}