import 'package:mobx/mobx.dart';

part 'cadastro_2_store.g.dart';

class Cadastro2Store = _Cadastro2Store with _$Cadastro2Store;

abstract class _Cadastro2Store with Store {
  _Cadastro2Store() {
    autorun((_) {
      print(cpf.length);
      print(pass.length);
    });
  }

  @observable
  String nome = "";

  @action
  void setNome(String value) => nome = value;

  @observable
  bool passVisible = false;

  @action
  void turnVisible() => passVisible = !passVisible;

  @observable
  String cpf = "";

  @action
  void setCpf(String value) => cpf = value;

  @observable
  String pass = "";

  @action
  void setPass(String value) => pass = value;

  @observable
  String confirmPass = "";

  @action
  void setConfirmPass(String value) => confirmPass = value;

  @observable
  String telefone = "";

  @action
  void setTelefone(String value) => telefone = value;

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String dataCNH = "";

  @action
  void setDataCNH(String value) => dataCNH = value;

  @computed
  bool get isFormValid =>
      pass.length > 3 &&
      pass == confirmPass &&
      telefone.length == 15 &&
      cpf.length == 14 &&
      nome.length > 6;
}
