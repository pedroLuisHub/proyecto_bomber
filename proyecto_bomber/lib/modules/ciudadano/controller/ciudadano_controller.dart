import 'dart:convert';
import 'dart:typed_data';

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
  reportLoading,
  reportGenerated,
  reportError,
}

class CiudadanoController = CiudadanoControllerBase with _$CiudadanoController;

List<Ciudadano> lista = [];

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

  @observable
  String? pdfBase64;

  @observable
  Uint8List? pdfBytes;

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
      final response = await _service.lista(condition);
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

  @action
  Future<void> reporteCiudadanos(String desde, String hasta) async {
    _status = CiudadanoStatusState.loading;
    Uint8List? resultPDF;
    try {
      resultPDF = await _service.reporteCiudadanos(desde, hasta);
      _status = CiudadanoStatusState.success;
      if (resultPDF != null) {
        pdfBytes = resultPDF;
        pdfBase64 = base64Encode(resultPDF); // Opcional, si necesitas base64
        _status = CiudadanoStatusState.reportGenerated;
      } else {
        message = 'No se pudo generar el reporte';
        _status = CiudadanoStatusState.reportError;
      }
    } on ServiceException catch (e) {
      message = e.message;
      _status = CiudadanoStatusState.error;
    }
  }

  setId(int id) {
    currentRecord = currentRecord.copyWith(id: id);
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
      message = "Ciudadano actualizado con exito";
      _status = CiudadanoStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el ciudadano');
      message = e.message;
      _status = CiudadanoStatusState.error;
    }
  }

  Future<void> removerCiudadano(int id) async {
    try {
      _status = CiudadanoStatusState.loading;
      await _service.eliminar(id);
      message = 'Ciudadano eliminado con éxito';
      await listaCiudadano(""); // recargar lista si es necesario
      _status = CiudadanoStatusState.delete;
    } on ServiceException {
      message =
          'No se puede eliminar el registro porque cuenta con dependencias';
      _status = CiudadanoStatusState.error;
    }
  }
}
