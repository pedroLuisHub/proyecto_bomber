import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/movil/repositories/movil_repository.dart';

class MovilService {
  final MovilRepository _repository;

  MovilService(this._repository);

  Future<List<Movil>> lista() async {
    try {
      return await _repository.lista();
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

    Future<void> eliminar(int id) async {
  try {
    return await _repository.eliminar(id);
  } on RepositoryException catch (e) {
    throw ServiceException(message: e.message ?? 'Error al eliminar el movil');
  }
}
}
