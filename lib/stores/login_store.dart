import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore(loginCpf, loginSenha, loginRemember) {
    if(loginCpf!=null){setCPF(loginCpf);}
    if(loginSenha!=null){setPass(loginSenha);}

    remember = loginRemember;
  }

  bool remember;

  @action
  Future rememberCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (remember) {
      prefs.setString("cpf", this.cpf);
      prefs.setString("pass", this.pass);
    } else {
      prefs.setString("cpf", "");
      prefs.setString("pass", "");
    }
  }

  @observable
  String cpf = "";

  @action
  void setCPF(String value) => cpf = value;

  @observable
  String pass = "";

  @action
  void setPass(String value) => pass = value;

  @observable
  var passVisible = true;

  @action
  void turnVisible() {
    passVisible = !passVisible;
  }

  @computed
  bool get isFormValid => pass.length>3&&cpf.length==14;
}
