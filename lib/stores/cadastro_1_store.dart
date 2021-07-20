import "package:mobx/mobx.dart";

part "cadastro_1_store.g.dart";

class Cadastro1Store = _Cadastro1Store with _$Cadastro1Store;

abstract class _Cadastro1Store with Store {
  _Cadastro1Store(cavalo, carreta1, carreta2, carreta3, rememberEquip) {
    if (cavalo != null) {
      this.placaCavalo = cavalo;
    }
    if (carreta1 != null) {
      this.placaCarreta1 = carreta1;
    }
    if (carreta2 != null) {
      this.placaCarreta2 = carreta2;
    }
    if (carreta3 != null) {
      this.placaCarreta3 = carreta3;
    }

    this.remember = rememberEquip;
    if (this.placaCarreta3 != "") {
      this.numCarretas = 3;
    } else if (this.placaCarreta2 != "") {
      this.numCarretas = 2;
    } else {
      this.numCarretas = 1;
    }
  }

  @observable
  var numCarretas;

  @action
  void addCarreta() {
    if (numCarretas < 3) {
      numCarretas++;
    }
  }

  @observable
  var remember;

  @action
  void turnRemember() => remember = !remember;

  @observable
  String placaCavalo = "";

  @action
  void setPlacaCavalo(String value) => placaCavalo = value.toUpperCase();

  @observable
  String placaCarreta1 = "";

  @action
  void setPlacaCarreta1(String value) => placaCarreta1 = value.toUpperCase();

  @observable
  String placaCarreta2 = "";

  @action
  void setPlacaCarreta2(String value) => placaCarreta2 = value.toUpperCase();

  @observable
  String placaCarreta3 = "";

  @action
  void setPlacaCarreta3(String value) => placaCarreta3 = value.toUpperCase();

  @computed
  bool get isFormValid =>
      placaCavalo.length == 8 &&
      (placaCarreta1.length == 0 || placaCarreta1.length == 8) &&
      (placaCarreta2.length == 0 || placaCarreta2.length == 8) &&
      (placaCarreta3.length == 0 || placaCarreta3.length == 8);
}
