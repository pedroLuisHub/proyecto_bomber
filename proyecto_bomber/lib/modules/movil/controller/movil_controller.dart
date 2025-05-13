import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/movil/services/movil_service.dart';
import 'package:mobx/mobx.dart';

part 'movil_controller.g.dart';

enum MovilStatusState {
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

class MovilController = MovilControllerBase with _$MovilController;

abstract class MovilControllerBase with Store {
  final MovilService _service;

  MovilControllerBase(this._service);

  @observable
  String? message;

  @observable
  ObservableList<Movil> lista = ObservableList<Movil>();

  @observable
  Movil currentRecord = Movil.novo();

  var estadoDeInsertar = true;

  @action
  void resetCurrentRecord() {
    currentRecord = Movil.novo();
    estadoDeInsertar = true;
  }

  @readonly
  MovilStatusState _status = MovilStatusState.initial;

  @action
  Future<void> listaMovil(String condition) async {
    _status = MovilStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = MovilStatusState.loaded;
    } on ServiceException catch (e) {
      message = e.message;
      _status = MovilStatusState.error;
    }
  }

  void setCurrentRecord(Movil movil) {
    currentRecord = movil;
  }


    @action
  void insertarMovil() {
    _status = MovilStatusState.loading;
    currentRecord = Movil.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = MovilStatusState.insertOrUpdate;
  }


  void setCapacidad(double capacidad) {
    currentRecord = currentRecord.copyWith(capacidad: capacidad);
  }

  void setDescripcion(String descripcion) {
    currentRecord = currentRecord.copyWith(descripcion: descripcion);
  }

  void setEstado(String estado) {
    currentRecord = currentRecord.copyWith(estado: estado);
    print('Estado asignado en el controlador: $estado');
  }

  void setTutorial(String tutorial) {
    currentRecord = currentRecord.copyWith(tutorial: tutorial);
  }

  Future<void> save() async {
    try {
      _status = MovilStatusState.loading;
      print(currentRecord.toJson());
      await _service.save(currentRecord);
      message = "Movil guardado con exito";
      _status = MovilStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el movil');
      message = e.message;
      _status = MovilStatusState.error;
    }
  }

  Future<void> actualizar(int idMovil) async {
    try {
      _status = MovilStatusState.loading;
      final movilActualizado = currentRecord.copyWith(id: idMovil);
      await _service.actualizar(movilActualizado);
      message = "Movil actualizado con exito";
      _status = MovilStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el movil');
      message = e.message;
      _status = MovilStatusState.error;
    }
  }

  Future<void> removerMovil(int id) async {
  try {
    _status = MovilStatusState.loading;
    await _service.eliminar(id);
    message = 'Bombero eliminado con éxito';
    await listaMovil(""); // recargar lista si es necesario
    _status = MovilStatusState.delete;
  } on ServiceException catch (e) {
    message = 'No se puede eliminar el registro porque cuenta con dependencias';
    _status = MovilStatusState.error;
  }
}
}
