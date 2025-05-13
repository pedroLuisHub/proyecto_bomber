import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:bomber/modules/ciudadano/services/ciudadano_service.dart';
import 'package:mobx/mobx.dart';

part 'ciudadano_controller.g.dart';

enum CiudadanoStatusState {
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

class CiudadanoController = CiudadanoControllerBase with _$CiudadanoController;

abstract class CiudadanoControllerBase with Store {
  final CiudadanoService _service;

  CiudadanoControllerBase(this._service);

  @observable
  String? message;

  @observable
  ObservableList<Ciudadano> lista = ObservableList<Ciudadano>();

  @observable
  Ciudadano currentRecord = Ciudadano.novo();

  var estadoDeInsertar = true;

  @action
  void resetCurrentRecord() {
    currentRecord = Ciudadano.novo();
    estadoDeInsertar = true;
  }

    @readonly
  CiudadanoStatusState _status = CiudadanoStatusState.initial;

  @action
  Future<void> listaCiudadano(String condition) async {
    _status = CiudadanoStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = CiudadanoStatusState.loaded;
      _status = CiudadanoStatusState.success;
      _status = CiudadanoStatusState.initial;
    } on ServiceException catch (e) {
      message = e.message;
      _status = CiudadanoStatusState.error;
    }
  }

  @action
  void setCurrentRecord(Ciudadano ciudadano) {
    currentRecord = ciudadano;
    estadoDeInsertar = false;
  }

  @action
  void insertarCiudadano() {
    _status = CiudadanoStatusState.loading;
    currentRecord = Ciudadano.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = CiudadanoStatusState.insertOrUpdate;
  }

  setNombre(String nombre) {
    currentRecord = currentRecord.copyWith(nombre: nombre);
  }

  setDocumento(String documento) {
    currentRecord = currentRecord.copyWith(documento: documento);
  }

  setApellido(String apellido) {
    currentRecord = currentRecord.copyWith(apellido: apellido);
  }

  setTelefono(String telefono) {
    currentRecord = currentRecord.copyWith(telefono: telefono);
  }

  setDireccion(String direccion) {
    currentRecord = currentRecord.copyWith(direccion: direccion);
  }

  setGenero(String genero) {
    currentRecord = currentRecord.copyWith(genero: genero);
  }

  setProfesion(String profesion) {
    currentRecord = currentRecord.copyWith(profesion: profesion);
  }

  
  setEmail(String email) {
    currentRecord = currentRecord.copyWith(email: email);
  }


  Future<void> save() async {
    try {
      _status = CiudadanoStatusState.loading;
      await _service.save(currentRecord);
      message = "Ciudadano guardado con exito";
      _status = CiudadanoStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el ciudadano');
      message = e.message;
      _status = CiudadanoStatusState.error;
    }
  }

  Future<void> actualizar(int idCiudadano) async {
    try {
      _status = CiudadanoStatusState.loading;
      final ciudadanoActualizado = currentRecord.copyWith(id: idCiudadano);
      await _service.actualizar(ciudadanoActualizado);
      message = "Ciudadano guardado con exito";
      _status = CiudadanoStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el ciudadano');
      message = e.message;
      _status = CiudadanoStatusState.error;
    }
  } 

}