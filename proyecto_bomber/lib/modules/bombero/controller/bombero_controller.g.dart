// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bombero_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BomberoController on BomberoControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'BomberoControllerBase.message', context: context);

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
      Atom(name: 'BomberoControllerBase.lista', context: context);

  @override
  ObservableList<Bombero> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Bombero> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'BomberoControllerBase.currentRecord', context: context);

  @override
  Bombero get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Bombero value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'BomberoControllerBase._status', context: context);

  BomberoStatusState get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  BomberoStatusState get _status => status;

  @override
  set _status(BomberoStatusState value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$listaBomberoAsyncAction =
      AsyncAction('BomberoControllerBase.listaBombero', context: context);

  @override
  Future<void> listaBombero(String condition) {
    return _$listaBomberoAsyncAction.run(() => super.listaBombero(condition));
  }

  late final _$BomberoControllerBaseActionController =
      ActionController(name: 'BomberoControllerBase', context: context);

  @override
  void resetCurrentRecord() {
    final _$actionInfo = _$BomberoControllerBaseActionController.startAction(
        name: 'BomberoControllerBase.resetCurrentRecord');
    try {
      return super.resetCurrentRecord();
    } finally {
      _$BomberoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentRecord(Bombero bombero) {
    final _$actionInfo = _$BomberoControllerBaseActionController.startAction(
        name: 'BomberoControllerBase.setCurrentRecord');
    try {
      return super.setCurrentRecord(bombero);
    } finally {
      _$BomberoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertarBombero() {
    final _$actionInfo = _$BomberoControllerBaseActionController.startAction(
        name: 'BomberoControllerBase.insertarBombero');
    try {
      return super.insertarBombero();
    } finally {
      _$BomberoControllerBaseActionController.endAction(_$actionInfo);
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
