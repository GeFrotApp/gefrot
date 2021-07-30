// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_3_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Cadastro3Store on _Cadastro3Store, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_Cadastro3Store.isFormValid'))
          .value;

  final _$cnpjAtom = Atom(name: '_Cadastro3Store.cnpj');

  @override
  String get cnpj {
    _$cnpjAtom.reportRead();
    return super.cnpj;
  }

  @override
  set cnpj(String value) {
    _$cnpjAtom.reportWrite(value, super.cnpj, () {
      super.cnpj = value;
    });
  }

  final _$nomeEmpresaAtom = Atom(name: '_Cadastro3Store.nomeEmpresa');

  @override
  String get nomeEmpresa {
    _$nomeEmpresaAtom.reportRead();
    return super.nomeEmpresa;
  }

  @override
  set nomeEmpresa(String value) {
    _$nomeEmpresaAtom.reportWrite(value, super.nomeEmpresa, () {
      super.nomeEmpresa = value;
    });
  }

  final _$check1Atom = Atom(name: '_Cadastro3Store.check1');

  @override
  bool get check1 {
    _$check1Atom.reportRead();
    return super.check1;
  }

  @override
  set check1(bool value) {
    _$check1Atom.reportWrite(value, super.check1, () {
      super.check1 = value;
    });
  }

  final _$_Cadastro3StoreActionController =
      ActionController(name: '_Cadastro3Store');

  @override
  void setCheck1(dynamic value) {
    final _$actionInfo = _$_Cadastro3StoreActionController.startAction(
        name: '_Cadastro3Store.setCheck1');
    try {
      return super.setCheck1(value);
    } finally {
      _$_Cadastro3StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNomeEmpresa(dynamic value) {
    final _$actionInfo = _$_Cadastro3StoreActionController.startAction(
        name: '_Cadastro3Store.setNomeEmpresa');
    try {
      return super.setNomeEmpresa(value);
    } finally {
      _$_Cadastro3StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCnpj(dynamic value) {
    final _$actionInfo = _$_Cadastro3StoreActionController.startAction(
        name: '_Cadastro3Store.setCnpj');
    try {
      return super.setCnpj(value);
    } finally {
      _$_Cadastro3StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cnpj: ${cnpj},
nomeEmpresa: ${nomeEmpresa},
check1: ${check1},
isFormValid: ${isFormValid}
    ''';
  }
}
