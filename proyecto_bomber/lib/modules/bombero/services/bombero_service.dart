import 'package:bomber/core/components/exceptions/repository_exception.dart';
import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/repositories/bombero_repository.dart';

class BomberoService {
  final BomberoRepository _repository;

  BomberoService(this._repository);

  Future<List<Bombero>> lista() async {
    try {
      return await _repository.lista();
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

  Future<void> eliminar(int id) async {
  try {
    return await _repository.eliminar(id);
  } on RepositoryException catch (e) {
    throw ServiceException(message: e.message ?? 'Error al eliminar el bombero');
  }
}

  
}
