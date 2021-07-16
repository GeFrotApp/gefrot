import "package:cloud_firestore/cloud_firestore.dart";
import "package:mobx/mobx.dart";

part "config_store.g.dart";

class ConfigStore = _ConfigStore with _$ConfigStore;

abstract class _ConfigStore with Store {
  @observable
  bool editNome = false;

  @action
  void turnEditNome() => editNome = !editNome;

  @action
  Future<void> setNome(id, nome) async {
    var firebase = FirebaseFirestore.instance;
    firebase.collection("Drivers").doc(id).update({
      "name":nome
    });
  }




  @observable
  bool editEmail = false;

  @action
  void turnEditMail() => editEmail = !editEmail;

  @action
  Future<void> setMail(id,mail) async {
    var firebase = FirebaseFirestore.instance;
    firebase.collection("Drivers").doc(id).update({
      "email":mail
    });
  }


  @observable
  bool editPhone = false;

  @action
  void turnEditPhone() => editPhone = !editPhone;

  @action
  Future<void> setPhone(id,phone) async {
    var firebase = FirebaseFirestore.instance;
    firebase.collection("Drivers").doc(id).update({
      "phone":phone
    });
  }


  @observable
  bool editCnh = false;

  @action
  void turnEditCnh() => editCnh = !editCnh;

  @action
  Future<void> setCnh(id,cnh) async {
    var firebase = FirebaseFirestore.instance;
    firebase.collection("Drivers").doc(id).update({
      "cnhDueDate":cnh
    });
  }
}
