// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jornada_base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JornadaBaseStore on _JornadaBaseStore, Store {
  final _$selectAtom = Atom(name: '_JornadaBaseStore.select');

  @override
  bool get select {
    _$selectAtom.reportRead();
    return super.select;
  }

  @override
  set select(bool value) {
    _$selectAtom.reportWrite(value, super.select, () {
      super.select = value;
    });
  }

  final _$indexAtom = Atom(name: '_JornadaBaseStore.index');

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  final _$jornadaAtom = Atom(name: '_JornadaBaseStore.jornada');

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

  final _$_JornadaBaseStoreActionController =
      ActionController(name: '_JornadaBaseStore');

  @override
  void setIndex(dynamic value) {
    final _$actionInfo = _$_JornadaBaseStoreActionController.startAction(
        name: '_JornadaBaseStore.setIndex');
    try {
      return super.setIndex(value);
    } finally {
      _$_JornadaBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnSelect() {
    final _$actionInfo = _$_JornadaBaseStoreActionController.startAction(
        name: '_JornadaBaseStore.turnSelect');
    try {
      return super.turnSelect();
    } finally {
      _$_JornadaBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnJornada() {
    final _$actionInfo = _$_JornadaBaseStoreActionController.startAction(
        name: '_JornadaBaseStore.turnJornada');
    try {
      return super.turnJornada();
    } finally {
      _$_JornadaBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
select: ${select},
index: ${index},
jornada: ${jornada}
    ''';
  }
}
