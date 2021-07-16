// GENERATED CODE - DO NOT MODIFY BY HAND

part of "pass_recover_store.dart";

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PassRecoverStore on _PassRecoverStore, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: "_PassRecoverStore.isFormValid"))
          .value;

  final _$cpfAtom = Atom(name: "_PassRecoverStore.cpf");

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

  final _$passAtom = Atom(name: "_PassRecoverStore.pass");

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

  final _$confirmPassAtom = Atom(name: "_PassRecoverStore.confirmPass");

  @override
  String get confirmPass {
    _$confirmPassAtom.reportRead();
    return super.confirmPass;
  }

  @override
  set confirmPass(String value) {
    _$confirmPassAtom.reportWrite(value, super.confirmPass, () {
      super.confirmPass = value;
    });
  }

  final _$passVisibleAtom = Atom(name: "_PassRecoverStore.passVisible");

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

  final _$cpfExistAtom = Atom(name: "_PassRecoverStore.cpfExist");

  @override
  bool get cpfExist {
    _$cpfExistAtom.reportRead();
    return super.cpfExist;
  }

  @override
  set cpfExist(bool value) {
    _$cpfExistAtom.reportWrite(value, super.cpfExist, () {
      super.cpfExist = value;
    });
  }

  final _$checkCpfAsyncAction = AsyncAction("_PassRecoverStore.checkCpf");

  @override
  Future<void> checkCpf(dynamic cpf) {
    return _$checkCpfAsyncAction.run(() => super.checkCpf(cpf));
  }

  final _$_PassRecoverStoreActionController =
      ActionController(name: "_PassRecoverStore");

  @override
  void setCpf(dynamic value) {
    final _$actionInfo = _$_PassRecoverStoreActionController.startAction(
        name: "_PassRecoverStore.setCpf");
    try {
      return super.setCpf(value);
    } finally {
      _$_PassRecoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass(dynamic value) {
    final _$actionInfo = _$_PassRecoverStoreActionController.startAction(
        name: "_PassRecoverStore.setPass");
    try {
      return super.setPass(value);
    } finally {
      _$_PassRecoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPass(dynamic value) {
    final _$actionInfo = _$_PassRecoverStoreActionController.startAction(
        name: "_PassRecoverStore.setConfirmPass");
    try {
      return super.setConfirmPass(value);
    } finally {
      _$_PassRecoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnVisible() {
    final _$actionInfo = _$_PassRecoverStoreActionController.startAction(
        name: "_PassRecoverStore.turnVisible");
    try {
      return super.turnVisible();
    } finally {
      _$_PassRecoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return """
cpf: ${cpf},
pass: ${pass},
confirmPass: ${confirmPass},
passVisible: ${passVisible},
cpfExist: ${cpfExist},
isFormValid: ${isFormValid}
    """;
  }
}
