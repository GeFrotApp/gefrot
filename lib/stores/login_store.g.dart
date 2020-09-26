// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_LoginStore.isFormValid'))
          .value;

  final _$cpfAtom = Atom(name: '_LoginStore.cpf');

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  final _$passAtom = Atom(name: '_LoginStore.pass');

  @override
  String get pass {
    _$passAtom.reportRead();
    return super.pass;
  }

  @override
  set pass(String value) {
    _$passAtom.reportWrite(value, super.pass, () {
      super.pass = value;
    });
  }

  final _$passVisibleAtom = Atom(name: '_LoginStore.passVisible');

  @override
  bool get passVisible {
    _$passVisibleAtom.reportRead();
    return super.passVisible;
  }

  @override
  set passVisible(bool value) {
    _$passVisibleAtom.reportWrite(value, super.passVisible, () {
      super.passVisible = value;
    });
  }

  final _$rememberCredentialsAsyncAction =
      AsyncAction('_LoginStore.rememberCredentials');

  @override
  Future<dynamic> rememberCredentials() {
    return _$rememberCredentialsAsyncAction
        .run(() => super.rememberCredentials());
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void setCPF(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setCPF');
    try {
      return super.setCPF(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setPass');
    try {
      return super.setPass(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnVisible() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.turnVisible');
    try {
      return super.turnVisible();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cpf: ${cpf},
pass: ${pass},
passVisible: ${passVisible},
isFormValid: ${isFormValid}
    ''';
  }
}
