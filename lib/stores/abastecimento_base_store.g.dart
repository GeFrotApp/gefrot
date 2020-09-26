// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abastecimento_base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbastecimentoBaseStore on _AbastecimentoBaseStore, Store {
  final _$selectAtom = Atom(name: '_AbastecimentoBaseStore.select');

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

  final _$indexAtom = Atom(name: '_AbastecimentoBaseStore.index');

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

  final _$_AbastecimentoBaseStoreActionController =
      ActionController(name: '_AbastecimentoBaseStore');

  @override
  void setIndex(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setIndex');
    try {
      return super.setIndex(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnSelect() {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.turnSelect');
    try {
      return super.turnSelect();
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
select: ${select},
index: ${index}
    ''';
  }
}
