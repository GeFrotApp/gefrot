// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_1_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Cadastro1Store on _Cadastro1Store, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_Cadastro1Store.isFormValid'))
          .value;

  final _$placaCavaloAtom = Atom(name: '_Cadastro1Store.placaCavalo');

  @override
  String get placaCavalo {
    _$placaCavaloAtom.reportRead();
    return super.placaCavalo;
  }

  @override
  set placaCavalo(String value) {
    _$placaCavaloAtom.reportWrite(value, super.placaCavalo, () {
      super.placaCavalo = value;
    });
  }

  final _$placaCarreta1Atom = Atom(name: '_Cadastro1Store.placaCarreta1');

  @override
  String get placaCarreta1 {
    _$placaCarreta1Atom.reportRead();
    return super.placaCarreta1;
  }

  @override
  set placaCarreta1(String value) {
    _$placaCarreta1Atom.reportWrite(value, super.placaCarreta1, () {
      super.placaCarreta1 = value;
    });
  }

  final _$placaCarreta2Atom = Atom(name: '_Cadastro1Store.placaCarreta2');

  @override
  String get placaCarreta2 {
    _$placaCarreta2Atom.reportRead();
    return super.placaCarreta2;
  }

  @override
  set placaCarreta2(String value) {
    _$placaCarreta2Atom.reportWrite(value, super.placaCarreta2, () {
      super.placaCarreta2 = value;
    });
  }

  final _$_Cadastro1StoreActionController =
      ActionController(name: '_Cadastro1Store');

  @override
  void setPlacaCavalo(String value) {
    final _$actionInfo = _$_Cadastro1StoreActionController.startAction(
        name: '_Cadastro1Store.setPlacaCavalo');
    try {
      return super.setPlacaCavalo(value);
    } finally {
      _$_Cadastro1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlacaCarreta1(String value) {
    final _$actionInfo = _$_Cadastro1StoreActionController.startAction(
        name: '_Cadastro1Store.setPlacaCarreta1');
    try {
      return super.setPlacaCarreta1(value);
    } finally {
      _$_Cadastro1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlacaCarreta2(String value) {
    final _$actionInfo = _$_Cadastro1StoreActionController.startAction(
        name: '_Cadastro1Store.setPlacaCarreta2');
    try {
      return super.setPlacaCarreta2(value);
    } finally {
      _$_Cadastro1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
placaCavalo: ${placaCavalo},
placaCarreta1: ${placaCarreta1},
placaCarreta2: ${placaCarreta2},
isFormValid: ${isFormValid}
    ''';
  }
}
