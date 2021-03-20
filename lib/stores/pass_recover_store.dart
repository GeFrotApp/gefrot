import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'pass_recover_store.g.dart';

class PassRecoverStore = _PassRecoverStore with _$PassRecoverStore;

abstract class _PassRecoverStore with Store {
  @observable
  var cpf = "";

  @observable
  var pass = "";

  @observable
  var confirmPass = "";

  @observable
  var passVisible = false;

  @observable
  var cpfExist = false;

  @action
  void setCpf(value) => cpf = value;

  @action
  void setPass(value) => pass = value;

  @action
  void setConfirmPass(value) => confirmPass = value;

  @action
  void turnVisible()=>passVisible = !passVisible;

  @action
  Future <void> checkCpf(cpf)async{
    this.cpf = cpf;
    if(cpf.length ==14){
      var document = FirebaseFirestore.instance
          .collection('Drivers')
          .doc(cpf.replaceAll('.', '').replaceAll('-', ''));
      document.get().then((DocumentSnapshot doc) {

        if (doc.exists) {
          print(doc.data());
          cpfExist = true;

        }else{
          cpfExist = false;
        }
      });
    }
  }

  @computed
  bool get isFormValid => pass.length > 3 && pass == confirmPass && cpf.length == 14 &&cpfExist;
}
