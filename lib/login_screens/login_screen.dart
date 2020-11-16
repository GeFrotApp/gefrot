import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_screens/base.dart';
import 'package:todomobx/login_screens/cadastro_1.dart';
import 'package:todomobx/main.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';
import 'package:todomobx/main.dart';

import '../main.dart';
import 'cadastro_2.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Dialog dialog;
  LoginStore loginStore;
  BaseStore baseStore;

  var remember = false;
  TextEditingController cpfController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    baseStore = Provider.of<BaseStore>(context);
    cpfController.text = loginStore.cpf;
    passController.text = loginStore.pass;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(header: "Acesse sua conta", image: "img3.jpeg", children: [
      SizedBox(
        height: 30,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Login",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Color.fromARGB(255, 137, 202, 204), fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Digite aqui seu CPF",
          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      CustomTextField(
        hint: '___.___.___-__',
        controller: cpfController,
        textInputType: TextInputType.number,
        formatter: new MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}),
        onChanged: loginStore.setCPF,
        enabled: true,
      ),
      const SizedBox(
        height: 16,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Digite aqui sua senha",
          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      Observer(
        builder: (_) {
          return CustomTextField(
            hint: 'Senha',
            onChanged: loginStore.setPass,
            controller: passController,
            enabled: true,
            obscure: !loginStore.passVisible,
            suffix: CustomIconButton(
              radius: 32,
              iconData: loginStore.passVisible ? Icons.visibility : Icons.visibility_off,
              onTap: loginStore.turnVisible,
            ),
          );
        },
      ),
      Row(
        children: <Widget>[
          Switch(
            activeColor: Color.fromARGB(255, 108, 190, 193),
            value: loginStore.remember,
            onChanged: (value) {
              setState(() {
                loginStore.remember = value;
              });
            },
          ),
          Text("Lembrar minha senha")
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Observer(
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.065,
            child: RaisedButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,children: <Widget>[
                  Text(
                    'Entrar',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056),
                  ),
                  Icon(Icons.exit_to_app)
                ]),
                color: loginStore.isFormValid ? Color.fromARGB(255, 137, 202, 204) : Colors.grey,
                textColor: Colors.white,
                onPressed: () async {
                  var document = FirebaseFirestore.instance
                      .collection('Drivers')
                      .doc(cpfController.text.replaceAll('.', '').replaceAll('-', ''));
                  document.get().then((DocumentSnapshot doc) {
                    print(doc.data());
                    if (doc['password'] == passController.text) {
                      baseStore.nome = capitalize(doc['name'].split(' ')[0] + " " + capitalize(doc['name'].split(' ')[1]));
                      baseStore.cpf = doc.id;
                      baseStore.cnpj =
                          doc["cnpj"].replaceAll('.', "").replaceAll(" ", "").replaceAll("/", "").replaceAll("-", "");
                      if (loginStore.remember) {
                        loginStore.rememberCredentials();
                      }
                      if (doc['companyApproval']) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro1()));
                      } else {
                        baseStore.showMyDialog(
                            context, "A empresa deve aprovar seu cadastro. Entrar em contato com o seu gestor.");
                      }
                    }
                  });
                }),
          );
        },
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.065,
        child: RaisedButton(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text('Cadastre-se',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056, color: Color.fromARGB(255, 25, 153, 158))),
          color: Color.fromARGB(255, 255, 255, 255),
          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cadastro2()));
          },
        ),
      )
    ]);
  }
}
