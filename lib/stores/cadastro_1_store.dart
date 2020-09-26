import 'package:mobx/mobx.dart';

part 'cadastro_1_store.g.dart';

class Cadastro1Store = _Cadastro1Store with _$Cadastro1Store;

abstract class _Cadastro1Store with Store {
  @observable
  String placaCavalo = "";

  @action
  void setPlacaCavalo(String value) => placaCavalo = value;

  @observable
  String placaCarreta1 = "";

  @action
  void setPlacaCarreta1(String value) => placaCarreta1 = value;

  @observable
  String placaCarreta2 = "";

  @action
  void setPlacaCarreta2(String value) => placaCarreta2 = value;

  @computed
  bool get isFormValid => placaCavalo.length == 8&&(placaCarreta1.length==0 || placaCarreta1.length==8)&&(placaCarreta2.length==0 || placaCarreta2.length==8);
}
