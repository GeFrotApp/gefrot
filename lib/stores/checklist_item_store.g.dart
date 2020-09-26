// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChecklistItemStore on _ChecklistItemStore, Store {
  final _$itemCodeAtom = Atom(name: '_ChecklistItemStore.itemCode');

  @override
  dynamic get itemCode {
    _$itemCodeAtom.reportRead();
    return super.itemCode;
  }

  @override
  set itemCode(dynamic value) {
    _$itemCodeAtom.reportWrite(value, super.itemCode, () {
      super.itemCode = value;
    });
  }

  final _$itemArrayAtom = Atom(name: '_ChecklistItemStore.itemArray');

  @override
  dynamic get itemArray {
    _$itemArrayAtom.reportRead();
    return super.itemArray;
  }

  @override
  set itemArray(dynamic value) {
    _$itemArrayAtom.reportWrite(value, super.itemArray, () {
      super.itemArray = value;
    });
  }

  final _$selectionArrayAtom = Atom(name: '_ChecklistItemStore.selectionArray');

  @override
  dynamic get selectionArray {
    _$selectionArrayAtom.reportRead();
    return super.selectionArray;
  }

  @override
  set selectionArray(dynamic value) {
    _$selectionArrayAtom.reportWrite(value, super.selectionArray, () {
      super.selectionArray = value;
    });
  }

  final _$_ChecklistItemStoreActionController =
      ActionController(name: '_ChecklistItemStore');

  @override
  void setItemCode(dynamic value) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setItemCode');
    try {
      return super.setItemCode(value);
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelection(dynamic index, dynamic value) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setSelection');
    try {
      return super.setSelection(index, value);
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setArray(dynamic value) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setArray');
    try {
      return super.setArray(value);
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemCode: ${itemCode},
itemArray: ${itemArray},
selectionArray: ${selectionArray}
    ''';
  }
}
