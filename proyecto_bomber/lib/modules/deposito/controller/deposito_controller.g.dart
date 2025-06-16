// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposito_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepositoController on DepositoControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'DepositoControllerBase.message', context: context);

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

  late final _$pdfBase64Atom =
      Atom(name: 'DepositoControllerBase.pdfBase64', context: context);

  @override
  String? get pdfBase64 {
    _$pdfBase64Atom.reportRead();
    return super.pdfBase64;
  }

  @override
  set pdfBase64(String? value) {
    _$pdfBase64Atom.reportWrite(value, super.pdfBase64, () {
      super.pdfBase64 = value;
    });
  }

  late final _$pdfBytesAtom =
      Atom(name: 'DepositoControllerBase.pdfBytes', context: context);

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
      Atom(name: 'DepositoControllerBase.lista', context: context);

  @override
  ObservableList<Deposito> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Deposito> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'DepositoControllerBase.currentRecord', context: context);

  @override
  Deposito get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Deposito value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'DepositoControllerBase._status', context: context);

  DepositoStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  DepositoStatusState get _status => status;

  @override
  set _status(DepositoStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$capacidadMinAtom =
      Atom(name: 'DepositoControllerBase.capacidadMin', context: context);

  @override
  double get capacidadMin {
    _$capacidadMinAtom.reportRead();
    return super.capacidadMin;
  }

  @override
  set capacidadMin(double value) {
    _$capacidadMinAtom.reportWrite(value, super.capacidadMin, () {
      super.capacidadMin = value;
    });
  }

  late final _$capacidadMaxAtom =
      Atom(name: 'DepositoControllerBase.capacidadMax', context: context);

  @override
  double get capacidadMax {
    _$capacidadMaxAtom.reportRead();
    return super.capacidadMax;
  }

  @override
  set capacidadMax(double value) {
    _$capacidadMaxAtom.reportWrite(value, super.capacidadMax, () {
      super.capacidadMax = value;
    });
  }

  late final _$listaDepositoAsyncAction =
      AsyncAction('DepositoControllerBase.listaDeposito', context: context);

  @override
  Future<void> listaDeposito(String condition) {
    return _$listaDepositoAsyncAction.run(() => super.listaDeposito(condition));
  }

  late final _$reporteDepositosAsyncAction =
      AsyncAction('DepositoControllerBase.reporteDepositos', context: context);

  @override
  Future<void> reporteDepositos(double capMin, double capMax) {
    return _$reporteDepositosAsyncAction
        .run(() => super.reporteDepositos(capMin, capMax));
  }

  late final _$DepositoControllerBaseActionController =
      ActionController(name: 'DepositoControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$DepositoControllerBaseActionController.startAction(
        name: 'DepositoControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$DepositoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarDeposito() {
    final _$actionInfo = _$DepositoControllerBaseActionController.startAction(
        name: 'DepositoControllerBase.insertarDeposito');
    try {
      return super.insertarDeposito();
    } finally {
      _$DepositoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCapacidadMin(double value) {
    final _$actionInfo = _$DepositoControllerBaseActionController.startAction(
        name: 'DepositoControllerBase.setCapacidadMin');
    try {
      return super.setCapacidadMin(value);
    } finally {
      _$DepositoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCapacidadMax(double value) {
    final _$actionInfo = _$DepositoControllerBaseActionController.startAction(
        name: 'DepositoControllerBase.setCapacidadMax');
    try {
      return super.setCapacidadMax(value);
    } finally {
      _$DepositoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCiudadano(Ciudadano ciudadano) {
    final _$actionInfo = _$DepositoControllerBaseActionController.startAction(
        name: 'DepositoControllerBase.setCiudadano');
    try {
      return super.setCiudadano(ciudadano);
    } finally {
      _$DepositoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
pdfBase64: ${pdfBase64},
pdfBytes: ${pdfBytes},
lista: ${lista},
currentRecord: ${currentRecord},
capacidadMin: ${capacidadMin},
capacidadMax: ${capacidadMax}
    ''';
  }
}
