import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/abastecimiento/model/abast/abastecimiento.dart';
import 'package:bomber/modules/abastecimiento/services/abastecimiento_service.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:mobx/mobx.dart';

part 'abastecimiento_controller.g.dart';

enum AbastecimientoStatusState {
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

class AbastecimientoController = AbastecimientoControllerBase with _$AbastecimientoController;

abstract class AbastecimientoControllerBase with Store {
  final AbastecimientoService _service;

  AbastecimientoControllerBase(this._service);

    @observable
  String? message;

  @observable
  ObservableList<Abastecimiento> lista = ObservableList<Abastecimiento>();

  @observable
  Abastecimiento currentRecord = Abastecimiento.novo();

  var estadoDeInsertar = true;

    @observable
  Uint8List? pdfBytes;

  @action
  void resetCurrentRecord() {
    currentRecord = Abastecimiento.novo();
    estadoDeInsertar = true;
  }

  @readonly
  AbastecimientoStatusState _status = AbastecimientoStatusState.initial;

    @action
  Future<void> listaAbastecimiento(String condition) async {
    _status = AbastecimientoStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = AbastecimientoStatusState.loaded;
    } on ServiceException catch (e) {
      message = e.message;
      _status = AbastecimientoStatusState.error;
    }
  }

  void setCurrentRecord(Abastecimiento abastecimiento) {
    currentRecord = abastecimiento;
  }

  @action
  void insertarAbastecimiento() {
    _status = AbastecimientoStatusState.loading;
    currentRecord = Abastecimiento.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = AbastecimientoStatusState.insertOrUpdate;
  }


  void setId(int id) {
    currentRecord = currentRecord.copyWith(id: id);
  }

  void setFechaInicio(DateTime fechaInicio) {
    currentRecord = currentRecord.copyWith(fechaInicio: fechaInicio);
  }
  
    void setFechaFin(DateTime fechaFin) {
    currentRecord = currentRecord.copyWith(fechaFin: fechaFin);
  }

  
  void setCantLitros(double cantLitros) {
    currentRecord = currentRecord.copyWith(cantLitros: cantLitros);
  }

  void setDescripcion(String descripcion) {
    currentRecord = currentRecord.copyWith(descripcion: descripcion);
  }

  
  void setCantViajes(int cantViajes) {
    currentRecord = currentRecord.copyWith(cantViajes: cantViajes);

  }

@action
  void setMovil(Movil movil) {
    currentRecord = currentRecord.copyWith(movil: movil);
  }

@action
  void setBombero(Bombero bombero) {
    currentRecord = currentRecord.copyWith(bombero: bombero);
  }

@action
  void setDeposito(Deposito depositoAgua) {
    currentRecord = currentRecord.copyWith(depositoAgua: depositoAgua);
  }


    late Observable<Abastecimiento> currentRecordd = Observable(Abastecimiento());

  Future<void> save() async {
    try {
      _status = AbastecimientoStatusState.loading;
      print(currentRecord.toJson());
      await _service.save(currentRecord);
      message = "Abastecimiento guardado con exito";
      _status = AbastecimientoStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el deposito');
      message = e.message;
      _status = AbastecimientoStatusState.error;
    }
  }
  

  Future<void> actualizar(int idAbastecimiento) async {
    try {
      _status = AbastecimientoStatusState.loading;
      final abastecimientoActualizado = currentRecord.copyWith(id: idAbastecimiento);
      await _service.actualizar(abastecimientoActualizado);
      message = "Abastecimiento actualizado con exito";
      print("Este es el id que manda $idAbastecimiento");
      _status = AbastecimientoStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar la abastecimiento');
      message = e.message;
      _status = AbastecimientoStatusState.error;
    }
  }

  Future<void> removerAbastecimiento(int id) async {
    try {
      _status = AbastecimientoStatusState.loading;
      await _service.eliminar(id);
      message = 'Deposito eliminado con éxito';
      await listaAbastecimiento(""); // abastecimientor lista si es necesario
      _status = AbastecimientoStatusState.delete;
    } on ServiceException {
      message =
          'No se puede eliminar el registro porque cuenta con dependencias';
      _status = AbastecimientoStatusState.error;
    }
  }

    @action
  Future<void> reporteAbastecimientos(String desde, String hasta) async {
    _status = AbastecimientoStatusState.loading;
    Uint8List? resultPDF;
    try {
      resultPDF = await _service.reporteAbastecimiento(desde, hasta);
      _status = AbastecimientoStatusState.success;
      if (resultPDF != null) {
        pdfBytes = resultPDF;
        _status = AbastecimientoStatusState.success;
      } else {
        message = 'No se pudo generar el reporte';
        _status = AbastecimientoStatusState.error;
      }
    } on ServiceException catch (e) {
      message = e.message;
      _status = AbastecimientoStatusState.error;
    }
  }
}