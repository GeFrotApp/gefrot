import 'package:mobx/mobx.dart';

part 'abastecimento_registro_store.g.dart';

class AbastecimentoRegistroStore = _AbastecimentoRegistroStore with _$AbastecimentoRegistroStore;

abstract class _AbastecimentoRegistroStore with Store{

  @observable
  var posto = "";

  @action
  void setPosto(value)=>posto = value;

  @observable
  var odometro = 0.0;

  @action
  void setOdometro(value)=>odometro = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var litros = 0.0;

  @action
  void setLitros(value)=>litros = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var valor = 0.0;

  @action
  void setValor(value)=>valor = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var nf = "";

  @action
  void setNf(value)=>nf = value;

  @observable
  var tanqueCheio = true;

  @action
  void setTanqueCheio(value)=>tanqueCheio=value;



}