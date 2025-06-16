import 'dart:convert';
import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/deposito/service/deposito_service.dart';
import 'package:mobx/mobx.dart';

part 'deposito_controller.g.dart';

enum DepositoStatusState {
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

class DepositoController = DepositoControllerBase with _$DepositoController;

abstract class DepositoControllerBase with Store {
  final DepositoService _service;

  DepositoControllerBase(this._service);

  @observable
  String? message;

  @observable
  String? pdfBase64;

  @observable
  Uint8List? pdfBytes;

  @observable
  ObservableList<Deposito> lista = ObservableList<Deposito>();

  @observable
  Deposito currentRecord = Deposito.novo();

  var estadoDeInsertar = true;

  @action
  void resetCurrentRecord() {
    currentRecord = Deposito.novo();
    estadoDeInsertar = true;
  }

  @readonly
  DepositoStatusState _status = DepositoStatusState.initial;

  @action
  Future<void> listaDeposito(String condition) async {
    _status = DepositoStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = DepositoStatusState.loaded;
    } on ServiceException catch (e) {
      message = e.message;
      _status = DepositoStatusState.error;
    }
  }

  void setCurrentRecord(Deposito deposito) {
    currentRecord = deposito;
  }

  @action
  void insertarDeposito() {
    _status = DepositoStatusState.loading;
    currentRecord = Deposito.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = DepositoStatusState.insertOrUpdate;
  }

  @action
  Future<void> reporteDepositos(double numMin, double numMax) async {
    _status = DepositoStatusState.loading;
    Uint8List? resultPDF;
    try {
      resultPDF = await _service.reporteDepositos(numMin, numMax);
      _status = DepositoStatusState.success;
      if (resultPDF != null) {
        pdfBytes = resultPDF;
        pdfBase64 = base64Encode(resultPDF); // Opcional, si necesitas base64
        _status = DepositoStatusState.reportGenerated;
      } else {
        message = 'No se pudo generar el reporte';
        _status = DepositoStatusState.reportError;
      }
    } on ServiceException catch (e) {
      message = e.message;
      _status = DepositoStatusState.error;
    }
  }

  @observable
  double capacidadMin = 0.0;

  @observable
  double capacidadMax = 0.0;

  @action
  void setCapacidadMin(double value) => capacidadMin = value;

  @action
  void setCapacidadMax(double value) => capacidadMax = value;

  void setId(int id) {
    currentRecord = currentRecord.copyWith(id: id);
  }

  void setLatitud(String latitud) {
    currentRecord = currentRecord.copyWith(latitud: latitud);
  }

  void setLongitud(String longitud) {
    currentRecord = currentRecord.copyWith(longitud: longitud);
  }

  void setCapacidad(double capacidad) {
    currentRecord = currentRecord.copyWith(capacidad: capacidad);
  }

  void setEstado(String estado) {
    currentRecord = currentRecord.copyWith(estado: estado);
    print('Estado asignado en el controlador: $estado');
  }

  @action
  void setCiudadano(Ciudadano ciudadano) {
    currentRecord = currentRecord.copyWith(ciudadano: ciudadano);
  }

  //   void setCiudadano(Ciudadano ciudadano) {
  //   currentRecord = currentRecord.copyWith(ciudadano: ciudadano);
  // }

  late Observable<Deposito> currentRecordd = Observable(Deposito());

  Future<void> save() async {
    try {
      _status = DepositoStatusState.loading;
      print(currentRecord.toJson());
      await _service.save(currentRecord);
      message = "Deposito guardado con exito";
      _status = DepositoStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el deposito');
      message = e.message;
      _status = DepositoStatusState.error;
    }
  }

  Future<void> actualizar(int idDeposito) async {
    try {
      _status = DepositoStatusState.loading;
      final depositoActualizado = currentRecord.copyWith(id: idDeposito);
      await _service.actualizar(depositoActualizado);
      message = "Deposito actualizado con exito";
      print("Este es el id que manda $idDeposito");
      _status = DepositoStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el deposito');
      message = e.message;
      _status = DepositoStatusState.error;
    }
  }

  Future<void> removerDeposito(int id) async {
    try {
      _status = DepositoStatusState.loading;
      await _service.eliminar(id);
      message = 'Deposito eliminado con éxito';
      await listaDeposito(""); // recargar lista si es necesario
      _status = DepositoStatusState.delete;
    } on ServiceException {
      message =
          'No se puede eliminar el registro porque cuenta con dependencias';
      _status = DepositoStatusState.error;
    }
  }
}
