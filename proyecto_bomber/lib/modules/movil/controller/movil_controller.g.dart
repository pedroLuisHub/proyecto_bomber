// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movil_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovilController on MovilControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'MovilControllerBase.message', context: context);

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
      Atom(name: 'MovilControllerBase.lista', context: context);

  @override
  ObservableList<Movil> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Movil> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'MovilControllerBase.currentRecord', context: context);

  @override
  Movil get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Movil value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'MovilControllerBase._status', context: context);

  MovilStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  MovilStatusState get _status => status;

  @override
  set _status(MovilStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$listaMovilAsyncAction =
      AsyncAction('MovilControllerBase.listaMovil', context: context);

  @override
  Future<void> listaMovil(String condition) {
    return _$listaMovilAsyncAction.run(() => super.listaMovil(condition));
  }

  late final _$MovilControllerBaseActionController =
      ActionController(name: 'MovilControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$MovilControllerBaseActionController.startAction(
        name: 'MovilControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$MovilControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarMovil() {
    final _$actionInfo = _$MovilControllerBaseActionController.startAction(
        name: 'MovilControllerBase.insertarMovil');
    try {
      return super.insertarMovil();
    } finally {
      _$MovilControllerBaseActionController.endAction(_$actionInfo);
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
