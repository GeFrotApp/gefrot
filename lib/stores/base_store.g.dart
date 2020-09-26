// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$jornadaAtom = Atom(name: '_BaseStore.jornada');

  @override
  bool get jornada {
    _$jornadaAtom.reportRead();
    return super.jornada;
  }

  @override
  set jornada(bool value) {
    _$jornadaAtom.reportWrite(value, super.jornada, () {
      super.jornada = value;
    });
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  void turnJornada() {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.turnJornada');
    try {
      return super.turnJornada();
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOdometro(dynamic value) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setOdometro');
    try {
      return super.setOdometro(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
jornada: ${jornada}
    ''';
  }
}
