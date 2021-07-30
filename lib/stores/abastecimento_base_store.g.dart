// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abastecimento_base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbastecimentoBaseStore on _AbastecimentoBaseStore, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_AbastecimentoBaseStore.isFormValid'))
          .value;

  final _$postoAtom = Atom(name: '_AbastecimentoBaseStore.posto');

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

  final _$cnpjPostoAtom = Atom(name: '_AbastecimentoBaseStore.cnpjPosto');

  @override
  String get cnpjPosto {
    _$cnpjPostoAtom.reportRead();
    return super.cnpjPosto;
  }

  @override
  set cnpjPosto(String value) {
    _$cnpjPostoAtom.reportWrite(value, super.cnpjPosto, () {
      super.cnpjPosto = value;
    });
  }

  final _$placaCavaloAtom = Atom(name: '_AbastecimentoBaseStore.placaCavalo');

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

  final _$nomePostoControllerAtom =
      Atom(name: '_AbastecimentoBaseStore.nomePostoController');

  @override
  TextEditingController get nomePostoController {
    _$nomePostoControllerAtom.reportRead();
    return super.nomePostoController;
  }

  @override
  set nomePostoController(TextEditingController value) {
    _$nomePostoControllerAtom.reportWrite(value, super.nomePostoController, () {
      super.nomePostoController = value;
    });
  }

  final _$dataAtom = Atom(name: '_AbastecimentoBaseStore.data');

  @override
  dynamic get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(dynamic value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$odometroNewAtom = Atom(name: '_AbastecimentoBaseStore.odometroNew');

  @override
  double get odometroNew {
    _$odometroNewAtom.reportRead();
    return super.odometroNew;
  }

  @override
  set odometroNew(double value) {
    _$odometroNewAtom.reportWrite(value, super.odometroNew, () {
      super.odometroNew = value;
    });
  }

  final _$odometroOldAtom = Atom(name: '_AbastecimentoBaseStore.odometroOld');

  @override
  double get odometroOld {
    _$odometroOldAtom.reportRead();
    return super.odometroOld;
  }

  @override
  set odometroOld(double value) {
    _$odometroOldAtom.reportWrite(value, super.odometroOld, () {
      super.odometroOld = value;
    });
  }

  final _$litrosAtom = Atom(name: '_AbastecimentoBaseStore.litros');

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

  final _$valorAtom = Atom(name: '_AbastecimentoBaseStore.valor');

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

  final _$nfAtom = Atom(name: '_AbastecimentoBaseStore.nf');

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

  final _$tanqueCheioAtom = Atom(name: '_AbastecimentoBaseStore.tanqueCheio');

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

  final _$invoicePhotoAtom = Atom(name: '_AbastecimentoBaseStore.invoicePhoto');

  @override
  dynamic get invoicePhoto {
    _$invoicePhotoAtom.reportRead();
    return super.invoicePhoto;
  }

  @override
  set invoicePhoto(dynamic value) {
    _$invoicePhotoAtom.reportWrite(value, super.invoicePhoto, () {
      super.invoicePhoto = value;
    });
  }

  final _$selectAtom = Atom(name: '_AbastecimentoBaseStore.select');

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

  final _$indexAtom = Atom(name: '_AbastecimentoBaseStore.index');

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

  final _$combustivelAtom = Atom(name: '_AbastecimentoBaseStore.combustivel');

  @override
  String get combustivel {
    _$combustivelAtom.reportRead();
    return super.combustivel;
  }

  @override
  set combustivel(String value) {
    _$combustivelAtom.reportWrite(value, super.combustivel, () {
      super.combustivel = value;
    });
  }

  final _$setCnpjPostoAsyncAction =
      AsyncAction('_AbastecimentoBaseStore.setCnpjPosto');

  @override
  Future<void> setCnpjPosto(dynamic value) {
    return _$setCnpjPostoAsyncAction.run(() => super.setCnpjPosto(value));
  }

  final _$setIndexAsyncAction = AsyncAction('_AbastecimentoBaseStore.setIndex');

  @override
  Future<void> setIndex(dynamic value, dynamic context, dynamic checkRegistro) {
    return _$setIndexAsyncAction
        .run(() => super.setIndex(value, context, checkRegistro));
  }

  final _$_AbastecimentoBaseStoreActionController =
      ActionController(name: '_AbastecimentoBaseStore');

  @override
  void setData(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setData');
    try {
      return super.setData(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPosto(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setPosto');
    try {
      return super.setPosto(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlacaCavalo(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setPlacaCavalo');
    try {
      return super.setPlacaCavalo(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewOdometro(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setNewOdometro');
    try {
      return super.setNewOdometro(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOldOdometro(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setOldOdometro');
    try {
      return super.setOldOdometro(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLitros(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setLitros');
    try {
      return super.setLitros(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValor(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setValor');
    try {
      return super.setValor(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNf(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setNf');
    try {
      return super.setNf(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTanqueCheio(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setTanqueCheio');
    try {
      return super.setTanqueCheio(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void turnSelect() {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.turnSelect');
    try {
      return super.turnSelect();
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCombustivel(dynamic value) {
    final _$actionInfo = _$_AbastecimentoBaseStoreActionController.startAction(
        name: '_AbastecimentoBaseStore.setCombustivel');
    try {
      return super.setCombustivel(value);
    } finally {
      _$_AbastecimentoBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posto: ${posto},
cnpjPosto: ${cnpjPosto},
placaCavalo: ${placaCavalo},
nomePostoController: ${nomePostoController},
data: ${data},
odometroNew: ${odometroNew},
odometroOld: ${odometroOld},
litros: ${litros},
valor: ${valor},
nf: ${nf},
tanqueCheio: ${tanqueCheio},
invoicePhoto: ${invoicePhoto},
select: ${select},
index: ${index},
combustivel: ${combustivel},
isFormValid: ${isFormValid}
    ''';
  }
}
