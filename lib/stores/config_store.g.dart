// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigStore on _ConfigStore, Store {
  final _$editNomeAtom = Atom(name: '_ConfigStore.editNome');

  @override
  bool get editNome {
    _$editNomeAtom.reportRead();
    return super.editNome;
  }

  @override
  set editNome(bool value) {
    _$editNomeAtom.reportWrite(value, super.editNome, () {
      super.editNome = value;
    });
  }

  final _$editEmailAtom = Atom(name: '_ConfigStore.editEmail');

  @override
  bool get editEmail {
    _$editEmailAtom.reportRead();
    return super.editEmail;
  }

  @override
  set editEmail(bool value) {
    _$editEmailAtom.reportWrite(value, super.editEmail, () {
      super.editEmail = value;
    });
  }

  final _$editPhoneAtom = Atom(name: '_ConfigStore.editPhone');

  @override
  bool get editPhone {
    _$editPhoneAtom.reportRead();
    return super.editPhone;
  }

  @override
  set editPhone(bool value) {
    _$editPhoneAtom.reportWrite(value, super.editPhone, () {
      super.editPhone = value;
    });
  }

  final _$editCnhAtom = Atom(name: '_ConfigStore.editCnh');

  @override
  bool get editCnh {
    _$editCnhAtom.reportRead();
    return super.editCnh;
  }

  @override
  set editCnh(bool value) {
    _$editCnhAtom.reportWrite(value, super.editCnh, () {
      super.editCnh = value;
    });
  }

  final _$setNomeAsyncAction = AsyncAction('_ConfigStore.setNome');

  @override
  Future<void> setNome(dynamic id, dynamic nome) {
    return _$setNomeAsyncAction.run(() => super.setNome(id, nome));
  }

  final _$setMailAsyncAction = AsyncAction('_ConfigStore.setMail');

  @override
  Future<void> setMail(dynamic id, dynamic mail) {
    return _$setMailAsyncAction.run(() => super.setMail(id, mail));
  }

  final _$setPhoneAsyncAction = AsyncAction('_ConfigStore.setPhone');

  @override
  Future<void> setPhone(dynamic id, dynamic phone) {
    return _$setPhoneAsyncAction.run(() => super.setPhone(id, phone));
  }

  final _$setCnhAsyncAction = AsyncAction('_ConfigStore.setCnh');

  @override
  Future<void> setCnh(dynamic id, dynamic cnh) {
    return _$setCnhAsyncAction.run(() => super.setCnh(id, cnh));
  }

  final _$_ConfigStoreActionController = ActionController(name: '_ConfigStore');

  @override
  void turnEditNome() {
    final _$actionInfo = _$_ConfigStoreActionController.startAction(name: '_ConfigStore.turnEditNome');
    try {
      return super.turnEditNome();
    } finally {
      _$_ConfigStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnEditMail() {
    final _$actionInfo = _$_ConfigStoreActionController.startAction(name: '_ConfigStore.turnEditMail');
    try {
      return super.turnEditMail();
    } finally {
      _$_ConfigStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnEditPhone() {
    final _$actionInfo = _$_ConfigStoreActionController.startAction(name: '_ConfigStore.turnEditPhone');
    try {
      return super.turnEditPhone();
    } finally {
      _$_ConfigStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnEditCnh() {
    final _$actionInfo = _$_ConfigStoreActionController.startAction(name: '_ConfigStore.turnEditCnh');
    try {
      return super.turnEditCnh();
    } finally {
      _$_ConfigStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
editNome: ${editNome},
editEmail: ${editEmail},
editPhone: ${editPhone},
editCnh: ${editCnh}
    ''';
  }
}
