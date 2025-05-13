// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ciudadano_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CiudadanoController on CiudadanoControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'CiudadanoControllerBase.message', context: context);

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
      Atom(name: 'CiudadanoControllerBase.lista', context: context);

  @override
  ObservableList<Ciudadano> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Ciudadano> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'CiudadanoControllerBase.currentRecord', context: context);

  @override
  Ciudadano get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Ciudadano value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'CiudadanoControllerBase._status', context: context);

  CiudadanoStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  CiudadanoStatusState get _status => status;

  @override
  set _status(CiudadanoStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$listaCiudadanoAsyncAction =
      AsyncAction('CiudadanoControllerBase.listaCiudadano', context: context);

  @override
  Future<void> listaCiudadano(String condition) {
    return _$listaCiudadanoAsyncAction
        .run(() => super.listaCiudadano(condition));
  }

  late final _$CiudadanoControllerBaseActionController =
      ActionController(name: 'CiudadanoControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$CiudadanoControllerBaseActionController.startAction(
        name: 'CiudadanoControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$CiudadanoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentRecord(Ciudadano ciudadano) {
    final _$actionInfo = _$CiudadanoControllerBaseActionController.startAction(
        name: 'CiudadanoControllerBase.setCurrentRecord');
    try {
      return super.setCurrentRecord(ciudadano);
    } finally {
      _$CiudadanoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarCiudadano() {
    final _$actionInfo = _$CiudadanoControllerBaseActionController.startAction(
        name: 'CiudadanoControllerBase.insertarCiudadano');
    try {
      return super.insertarCiudadano();
    } finally {
      _$CiudadanoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
lista: ${lista},
currentRecord: ${currentRecord}
    ''';
  }
}
