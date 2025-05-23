import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/repositories/bombero_repository.dart';
import 'package:bomber/modules/bombero/services/bombero_service.dart';
import 'package:mobx/mobx.dart';

part 'bombero_controller.g.dart';

enum BomberoStatusState {
  initial,
  loading,
  loaded,
  success,
  error,
  insertOrUpdate,
  edit,
  delete,
  actualizado,
}


class BomberoController = BomberoControllerBase with _$BomberoController;

abstract class BomberoControllerBase with Store {
  final BomberoService _service;

  BomberoControllerBase(this._service);

  @observable
  String? message;

  @observable
  ObservableList<Bombero> lista = ObservableList<Bombero>();

  @observable
  Bombero currentRecord = Bombero.novo();

  var estadoDeInsertar = true;

  @action
  void resetCurrentRecord() {
    currentRecord = Bombero.novo();
    estadoDeInsertar = true;
  }

  @readonly
  BomberoStatusState _status = BomberoStatusState.initial;

  @action
  Future<void> listaBombero(String condition) async {
    _status = BomberoStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = BomberoStatusState.loaded;
      _status = BomberoStatusState.success;
      _status = BomberoStatusState.initial;
    } on ServiceException catch (e) {
      message = e.message;
      _status = BomberoStatusState.error;
    }
  }

  @action
  void setCurrentRecord(Bombero bombero) {
    currentRecord = bombero;
    estadoDeInsertar = false;
  }

  @action
  void insertarBombero() {
    _status = BomberoStatusState.loading;
    currentRecord = Bombero.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = BomberoStatusState.insertOrUpdate;
  }

  void setId(int id) {
    currentRecord = currentRecord.copyWith(id: id);
  }

  void setNombre(String nombre) {
    currentRecord = currentRecord.copyWith(nombre: nombre);
  }

  void setDocumento(String documento) {
    currentRecord = currentRecord.copyWith(documento: documento);
  }

  void setApellido(String apellido) {
    currentRecord = currentRecord.copyWith(apellido: apellido);
  }

  void setTelefono(String telefono) {
    currentRecord = currentRecord.copyWith(telefono: telefono);
  }

  void setDireccion(String direccion) {
    currentRecord = currentRecord.copyWith(direccion: direccion);
  }

  void setCargo(String cargo) {
    currentRecord = currentRecord.copyWith(cargo: cargo);
  }

  void setEmail(String email) {
    currentRecord = currentRecord.copyWith(email: email);
  }

  Future<void> save() async {
    try {
      _status = BomberoStatusState.loading;
      await _service.save(currentRecord);
      message = "Bombero guardado con exito";
      _status = BomberoStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el bombero');
      message = e.message;
      _status = BomberoStatusState.error;
    }
  }

  Future<void> actualizar(int idBombero) async {
    try {
      _status = BomberoStatusState.loading;
      final bomberoActualizado = currentRecord.copyWith(id: idBombero);
      await _service.actualizar(bomberoActualizado);
      message = "Bombero guardado con exito";
      _status = BomberoStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el bombero');
      message = e.message;
      _status = BomberoStatusState.error;
    }
  }


Future<void> removerBombero(int id) async {
  try {
    _status = BomberoStatusState.loading;
    await _service.eliminar(id);
    message = 'Bombero eliminado con éxito';
    await listaBombero(""); // recargar lista si es necesario
    _status = BomberoStatusState.delete;
  } on ServiceException catch (e) {
    message = 'No se puede eliminar el registro porque cuenta con dependencias';
    _status = BomberoStatusState.error;
  }
}

}
