// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recarga_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecargaController on RecargaControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'RecargaControllerBase.message', context: context);

  @override
  String? get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String? value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$pdfBytesAtom =
      Atom(name: 'RecargaControllerBase.pdfBytes', context: context);

  @override
  Uint8List? get pdfBytes {
    _$pdfBytesAtom.reportRead();
    return super.pdfBytes;
  }

  @override
  set pdfBytes(Uint8List? value) {
    _$pdfBytesAtom.reportWrite(value, super.pdfBytes, () {
      super.pdfBytes = value;
    });
  }

  late final _$listaAtom =
      Atom(name: 'RecargaControllerBase.lista', context: context);

  @override
  ObservableList<Recarga> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Recarga> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'RecargaControllerBase.currentRecord', context: context);

  @override
  Recarga get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Recarga value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'RecargaControllerBase._status', context: context);

  RecargaStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  RecargaStatusState get _status => status;

  @override
  set _status(RecargaStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$listaRecargaAsyncAction =
      AsyncAction('RecargaControllerBase.listaRecarga', context: context);

  @override
  Future<void> listaRecarga(String condition) {
    return _$listaRecargaAsyncAction.run(() => super.listaRecarga(condition));
  }

  late final _$reporteRecargasAsyncAction =
      AsyncAction('RecargaControllerBase.reporteRecargas', context: context);

  @override
  Future<void> reporteRecargas(String desde, String hasta) {
    return _$reporteRecargasAsyncAction
        .run(() => super.reporteRecargas(desde, hasta));
  }

  late final _$RecargaControllerBaseActionController =
      ActionController(name: 'RecargaControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$RecargaControllerBaseActionController.startAction(
        name: 'RecargaControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$RecargaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarRecarga() {
    final _$actionInfo = _$RecargaControllerBaseActionController.startAction(
        name: 'RecargaControllerBase.insertarRecarga');
    try {
      return super.insertarRecarga();
    } finally {
      _$RecargaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMovil(Movil movil) {
    final _$actionInfo = _$RecargaControllerBaseActionController.startAction(
        name: 'RecargaControllerBase.setMovil');
    try {
      return super.setMovil(movil);
    } finally {
      _$RecargaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBombero(Bombero bombero) {
    final _$actionInfo = _$RecargaControllerBaseActionController.startAction(
        name: 'RecargaControllerBase.setBombero');
    try {
      return super.setBombero(bombero);
    } finally {
      _$RecargaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeposito(Deposito depositoAgua) {
    final _$actionInfo = _$RecargaControllerBaseActionController.startAction(
        name: 'RecargaControllerBase.setDeposito');
    try {
      return super.setDeposito(depositoAgua);
    } finally {
      _$RecargaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
pdfBytes: ${pdfBytes},
lista: ${lista},
currentRecord: ${currentRecord}
    ''';
  }
}
