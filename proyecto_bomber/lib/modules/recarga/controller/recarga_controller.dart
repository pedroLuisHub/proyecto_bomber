import 'dart:typed_data';

import 'package:bomber/core/components/exceptions/service_exception.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/recarga/model/recarga.dart';
import 'package:bomber/modules/recarga/service/recarga_service.dart';
import 'package:mobx/mobx.dart';

part 'recarga_controller.g.dart';

enum RecargaStatusState {
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

class RecargaController = RecargaControllerBase with _$RecargaController;

abstract class RecargaControllerBase with Store {
  final RecargaService _service;

  RecargaControllerBase(this._service);

  @observable
  String? message;

  @observable
  Uint8List? pdfBytes;

  @observable
  ObservableList<Recarga> lista = ObservableList<Recarga>();

  @observable
  Recarga currentRecord = Recarga.novo();

  var estadoDeInsertar = true;

  @action
  void resetCurrentRecord() {
    currentRecord = Recarga.novo();
    estadoDeInsertar = true;
  }

  @readonly
  RecargaStatusState _status = RecargaStatusState.initial;

  @action
  Future<void> listaRecarga(String condition) async {
    _status = RecargaStatusState.loading;
    try {
      final response = await _service.lista();
      lista = response.asObservable();
      _status = RecargaStatusState.loaded;
    } on ServiceException catch (e) {
      message = e.message;
      _status = RecargaStatusState.error;
    }
  }

  void setCurrentRecord(Recarga recarga) {
    currentRecord = recarga;
  }

  @action
  void insertarRecarga() {
    _status = RecargaStatusState.loading;
    currentRecord = Recarga.novo();
    Future.delayed(const Duration(seconds: 0));
    _status = RecargaStatusState.insertOrUpdate;
  }

  void setId(int id) {
    currentRecord = currentRecord.copyWith(id: id);
  }

  void setFecha_hora(DateTime fecha_hora) {
    currentRecord = currentRecord.copyWith(fecha_hora: fecha_hora);
  }

  void setDescripcion(String descripcion) {
    currentRecord = currentRecord.copyWith(descripcion: descripcion);
  }

  void setCantidad_litros(double cantidad_litros) {
    currentRecord = currentRecord.copyWith(cantidad_litros: cantidad_litros);
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

  late Observable<Recarga> currentRecordd = Observable(Recarga());

  Future<void> save() async {
    try {
      _status = RecargaStatusState.loading;
      print(currentRecord.toJson());
      await _service.save(currentRecord);
      message = "Recarga guardado con exito";
      _status = RecargaStatusState.success;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar el deposito');
      message = e.message;
      _status = RecargaStatusState.error;
    }
  }

  Future<void> actualizar(int idRecarga) async {
    try {
      _status = RecargaStatusState.loading;
      final recargaActualizado = currentRecord.copyWith(id: idRecarga);
      await _service.actualizar(recargaActualizado);
      message = "Recarga actualizado con exito";
      print("Este es el id que manda $idRecarga");
      _status = RecargaStatusState.actualizado;
    } on ServiceException catch (e) {
      // throw ServiceException(message: e.message ?? 'Error al guardar la recarga');
      message = e.message;
      _status = RecargaStatusState.error;
    }
  }

  Future<void> removerRecarga(int id) async {
    try {
      _status = RecargaStatusState.loading;
      await _service.eliminar(id);
      message = 'Deposito eliminado con éxito';
      await listaRecarga(""); // recargar lista si es necesario
      _status = RecargaStatusState.delete;
    } on ServiceException {
      message =
          'No se puede eliminar el registro porque cuenta con dependencias';
      _status = RecargaStatusState.error;
    }
  }

  @action
  Future<void> reporteRecargas(String desde, String hasta) async {
    _status = RecargaStatusState.loading;
    Uint8List? resultPDF;
    try {
      resultPDF = await _service.reporteRecarga(desde, hasta);
      _status = RecargaStatusState.success;
      if (resultPDF != null) {
        pdfBytes = resultPDF;
        _status = RecargaStatusState.success;
      } else {
        message = 'No se pudo generar el reporte';
        _status = RecargaStatusState.error;
      }
    } on ServiceException catch (e) {
      message = e.message;
      _status = RecargaStatusState.error;
    }
  }
}
