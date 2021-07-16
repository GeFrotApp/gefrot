import "package:mobx/mobx.dart";

part "cadastro_3_store.g.dart";

class Cadastro3Store = _Cadastro3Store with _$Cadastro3Store;

abstract class _Cadastro3Store with Store {
  @observable
  String cnpj = "";

  @observable
  String nomeEmpresa = "";

  @observable
  var check1 = false;


  @action
  void setCheck1(value)=>check1 = value;


  @action
  void setNomeEmpresa(value) => nomeEmpresa = value;

  @action
  void setCnpj(value) => cnpj = value;

  @computed
  bool get isFormValid => cnpj.length == 20&&nomeEmpresa !=""&&nomeEmpresa!="Empresa não cadastrada"&&check1;
}
