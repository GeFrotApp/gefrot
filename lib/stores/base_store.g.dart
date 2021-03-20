// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$loadingAtom = Atom(name: '_BaseStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$jornadaAtom = Atom(name: '_BaseStore.jornada');

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

  final _$warningsAtom = Atom(name: '_BaseStore.warnings');

  @override
  int get warnings {
    _$warningsAtom.reportRead();
    return super.warnings;
  }

  @override
  set warnings(int value) {
    _$warningsAtom.reportWrite(value, super.warnings, () {
      super.warnings = value;
    });
  }

  final _$onlineAtom = Atom(name: '_BaseStore.online');

  @override
  bool get online {
    _$onlineAtom.reportRead();
    return super.online;
  }

  @override
  set online(bool value) {
    _$onlineAtom.reportWrite(value, super.online, () {
      super.online = value;
    });
  }

  final _$nomeAtom = Atom(name: '_BaseStore.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$vencimentoCNHAtom = Atom(name: '_BaseStore.vencimentoCNH');

  @override
  String get vencimentoCNH {
    _$vencimentoCNHAtom.reportRead();
    return super.vencimentoCNH;
  }

  @override
  set vencimentoCNH(String value) {
    _$vencimentoCNHAtom.reportWrite(value, super.vencimentoCNH, () {
      super.vencimentoCNH = value;
    });
  }

  final _$telefoneAtom = Atom(name: '_BaseStore.telefone');

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  final _$emailAtom = Atom(name: '_BaseStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  void turnLoading() {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.turnLoading');
    try {
      return super.turnLoading();
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWarnings(dynamic value) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setWarnings');
    try {
      return super.setWarnings(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNome(dynamic value) {
    final _$actionInfo =
        _$_BaseStoreActionController.startAction(name: '_BaseStore.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCNH(dynamic value) {
    final _$actionInfo =
        _$_BaseStoreActionController.startAction(name: '_BaseStore.setCNH');
    try {
      return super.setCNH(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTelefone(dynamic value) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setTelefone');
    try {
      return super.setTelefone(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEmail(dynamic value) {
    final _$actionInfo =
        _$_BaseStoreActionController.startAction(name: '_BaseStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOdometro(dynamic value) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setOdometro');
    try {
      return super.setOdometro(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
jornada: ${jornada},
warnings: ${warnings},
online: ${online},
nome: ${nome},
vencimentoCNH: ${vencimentoCNH},
telefone: ${telefone},
email: ${email}
    ''';
  }
}
