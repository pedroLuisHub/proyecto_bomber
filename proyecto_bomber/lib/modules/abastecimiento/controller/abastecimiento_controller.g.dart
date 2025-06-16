// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abastecimiento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AbastecimientoController on AbastecimientoControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'AbastecimientoControllerBase.message', context: context);

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

  late final _$listaAtom =
      Atom(name: 'AbastecimientoControllerBase.lista', context: context);

  @override
  ObservableList<Abastecimiento> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Abastecimiento> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom = Atom(
      name: 'AbastecimientoControllerBase.currentRecord', context: context);

  @override
  Abastecimiento get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Abastecimiento value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$pdfBytesAtom =
      Atom(name: 'AbastecimientoControllerBase.pdfBytes', context: context);

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

  late final _$_statusAtom =
      Atom(name: 'AbastecimientoControllerBase._status', context: context);

  AbastecimientoStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  AbastecimientoStatusState get _status => status;

  @override
  set _status(AbastecimientoStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$listaAbastecimientoAsyncAction = AsyncAction(
      'AbastecimientoControllerBase.listaAbastecimiento',
      context: context);

  @override
  Future<void> listaAbastecimiento(String condition) {
    return _$listaAbastecimientoAsyncAction
        .run(() => super.listaAbastecimiento(condition));
  }

  late final _$reporteAbastecimientosAsyncAction = AsyncAction(
      'AbastecimientoControllerBase.reporteAbastecimientos',
      context: context);

  @override
  Future<void> reporteAbastecimientos(String desde, String hasta) {
    return _$reporteAbastecimientosAsyncAction
        .run(() => super.reporteAbastecimientos(desde, hasta));
  }

  late final _$AbastecimientoControllerBaseActionController =
      ActionController(name: 'AbastecimientoControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$AbastecimientoControllerBaseActionController
        .startAction(name: 'AbastecimientoControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$AbastecimientoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarAbastecimiento() {
    final _$actionInfo =
        _$AbastecimientoControllerBaseActionController.startAction(
            name: 'AbastecimientoControllerBase.insertarAbastecimiento');
    try {
      return super.insertarAbastecimiento();
    } finally {
      _$AbastecimientoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMovil(Movil movil) {
    final _$actionInfo = _$AbastecimientoControllerBaseActionController
        .startAction(name: 'AbastecimientoControllerBase.setMovil');
    try {
      return super.setMovil(movil);
    } finally {
      _$AbastecimientoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBombero(Bombero bombero) {
    final _$actionInfo = _$AbastecimientoControllerBaseActionController
        .startAction(name: 'AbastecimientoControllerBase.setBombero');
    try {
      return super.setBombero(bombero);
    } finally {
      _$AbastecimientoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeposito(Deposito depositoAgua) {
    final _$actionInfo = _$AbastecimientoControllerBaseActionController
        .startAction(name: 'AbastecimientoControllerBase.setDeposito');
    try {
      return super.setDeposito(depositoAgua);
    } finally {
      _$AbastecimientoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
lista: ${lista},
currentRecord: ${currentRecord},
pdfBytes: ${pdfBytes}
    ''';
  }
}
