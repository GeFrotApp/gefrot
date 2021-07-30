// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChecklistItemStore on _ChecklistItemStore, Store {
  final _$onlineAtom = Atom(name: '_ChecklistItemStore.online');

  @override
  dynamic get online {
    _$onlineAtom.reportRead();
    return super.online;
  }

  @override
  set online(dynamic value) {
    _$onlineAtom.reportWrite(value, super.online, () {
      super.online = value;
    });
  }

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

  final _$buttonQtyAtom = Atom(name: '_ChecklistItemStore.buttonQty');

  @override
  dynamic get buttonQty {
    _$buttonQtyAtom.reportRead();
    return super.buttonQty;
  }

  @override
  set buttonQty(dynamic value) {
    _$buttonQtyAtom.reportWrite(value, super.buttonQty, () {
      super.buttonQty = value;
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

  final _$actionArrayAtom = Atom(name: '_ChecklistItemStore.actionArray');

  @override
  dynamic get actionArray {
    _$actionArrayAtom.reportRead();
    return super.actionArray;
  }

  @override
  set actionArray(dynamic value) {
    _$actionArrayAtom.reportWrite(value, super.actionArray, () {
      super.actionArray = value;
    });
  }

  final _$isFormValidAtom = Atom(name: '_ChecklistItemStore.isFormValid');

  @override
  bool get isFormValid {
    _$isFormValidAtom.reportRead();
    return super.isFormValid;
  }

  @override
  set isFormValid(bool value) {
    _$isFormValidAtom.reportWrite(value, super.isFormValid, () {
      super.isFormValid = value;
    });
  }

  final _$inputArrayAtom = Atom(name: '_ChecklistItemStore.inputArray');

  @override
  ObservableMap<dynamic, dynamic> get inputArray {
    _$inputArrayAtom.reportRead();
    return super.inputArray;
  }

  @override
  set inputArray(ObservableMap<dynamic, dynamic> value) {
    _$inputArrayAtom.reportWrite(value, super.inputArray, () {
      super.inputArray = value;
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
  void setInput(dynamic index, dynamic value, dynamic type) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setInput');
    try {
      return super.setInput(index, value, type);
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int deleteInput(dynamic index, dynamic value, dynamic type) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.deleteInput');
    try {
      return super.deleteInput(index, value, type);
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAction(dynamic index, dynamic value) {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setAction');
    try {
      return super.setAction(index, value);
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
  void setFormValid() {
    final _$actionInfo = _$_ChecklistItemStoreActionController.startAction(
        name: '_ChecklistItemStore.setFormValid');
    try {
      return super.setFormValid();
    } finally {
      _$_ChecklistItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
online: ${online},
itemCode: ${itemCode},
buttonQty: ${buttonQty},
itemArray: ${itemArray},
selectionArray: ${selectionArray},
actionArray: ${actionArray},
isFormValid: ${isFormValid},
inputArray: ${inputArray}
    ''';
  }
}
