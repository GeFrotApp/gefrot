// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChecklistBaseStore on _ChecklistBaseStore, Store {
  final _$selectAtom = Atom(name: '_ChecklistBaseStore.select');

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

  final _$indexAtom = Atom(name: '_ChecklistBaseStore.index');

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

  final _$_ChecklistBaseStoreActionController = ActionController(name: '_ChecklistBaseStore');

  @override
  void setIndex(dynamic value) {
    final _$actionInfo = _$_ChecklistBaseStoreActionController.startAction(name: '_ChecklistBaseStore.setIndex');
    try {
      return super.setIndex(value);
    } finally {
      _$_ChecklistBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnSelect() {
    final _$actionInfo = _$_ChecklistBaseStoreActionController.startAction(name: '_ChecklistBaseStore.turnSelect');
    try {
      return super.turnSelect();
    } finally {
      _$_ChecklistBaseStoreActionController.endAction(_$actionInfo);
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
