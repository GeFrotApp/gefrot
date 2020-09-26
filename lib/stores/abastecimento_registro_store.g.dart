// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abastecimento_registro_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbastecimentoRegistroStore on _AbastecimentoRegistroStore, Store {
  final _$postoAtom = Atom(name: '_AbastecimentoRegistroStore.posto');

  @override
  String get posto {
    _$postoAtom.reportRead();
    return super.posto;
  }

  @override
  set posto(String value) {
    _$postoAtom.reportWrite(value, super.posto, () {
      super.posto = value;
    });
  }

  final _$odometroAtom = Atom(name: '_AbastecimentoRegistroStore.odometro');

  @override
  double get odometro {
    _$odometroAtom.reportRead();
    return super.odometro;
  }

  @override
  set odometro(double value) {
    _$odometroAtom.reportWrite(value, super.odometro, () {
      super.odometro = value;
    });
  }

  final _$litrosAtom = Atom(name: '_AbastecimentoRegistroStore.litros');

  @override
  double get litros {
    _$litrosAtom.reportRead();
    return super.litros;
  }

  @override
  set litros(double value) {
    _$litrosAtom.reportWrite(value, super.litros, () {
      super.litros = value;
    });
  }

  final _$valorAtom = Atom(name: '_AbastecimentoRegistroStore.valor');

  @override
  double get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(double value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  final _$nfAtom = Atom(name: '_AbastecimentoRegistroStore.nf');

  @override
  String get nf {
    _$nfAtom.reportRead();
    return super.nf;
  }

  @override
  set nf(String value) {
    _$nfAtom.reportWrite(value, super.nf, () {
      super.nf = value;
    });
  }

  final _$tanqueCheioAtom =
      Atom(name: '_AbastecimentoRegistroStore.tanqueCheio');

  @override
  bool get tanqueCheio {
    _$tanqueCheioAtom.reportRead();
    return super.tanqueCheio;
  }

  @override
  set tanqueCheio(bool value) {
    _$tanqueCheioAtom.reportWrite(value, super.tanqueCheio, () {
      super.tanqueCheio = value;
    });
  }

  final _$_AbastecimentoRegistroStoreActionController =
      ActionController(name: '_AbastecimentoRegistroStore');

  @override
  void setPosto(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setPosto');
    try {
      return super.setPosto(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOdometro(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setOdometro');
    try {
      return super.setOdometro(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLitros(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setLitros');
    try {
      return super.setLitros(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValor(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setValor');
    try {
      return super.setValor(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNf(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setNf');
    try {
      return super.setNf(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTanqueCheio(dynamic value) {
    final _$actionInfo = _$_AbastecimentoRegistroStoreActionController
        .startAction(name: '_AbastecimentoRegistroStore.setTanqueCheio');
    try {
      return super.setTanqueCheio(value);
    } finally {
      _$_AbastecimentoRegistroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posto: ${posto},
odometro: ${odometro},
litros: ${litros},
valor: ${valor},
nf: ${nf},
tanqueCheio: ${tanqueCheio}
    ''';
  }
}
