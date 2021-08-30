import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:crypto/crypto.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";
import "package:provider/provider.dart";
import "package:todomobx/login_screens/cadastro_1.dart";
import "package:todomobx/login_screens/pass_recover_1.dart";
import "package:todomobx/main.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/login_store.dart";
import 'package:todomobx/utils/Logger.dart';
import "package:todomobx/widgets/custom_background.dart";
import "package:todomobx/widgets/custom_pass_text_field.dart";
import "package:todomobx/widgets/custom_text_field.dart";

import "../main.dart";
import "cadastro_2.dart";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Dialog dialog;
  bool splashScreen = true;
  late LoginStore loginStore;
  late BaseStore baseStore;
  List<String> warnings = ["supply"];
  var loading = false;

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
  void initState(){
    Future.delayed(Duration(seconds: 2)).then((value) => setState(() {
      splashScreen = false;
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return splashScreen?Container(child: Image.asset("assets/images/splashscreen.png", fit: BoxFit.fill,),):CustomBackground(
        header: "Acesse sua conta",
        children: loading
            ? [
                Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            child: CircularProgressIndicator(
                                strokeWidth: 10,
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                backgroundColor: Color.fromARGB(255, 137, 202, 204)),
                          ),
                        )))
              ]
            : [
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
                  hint: "___.___.___-__",
                  controller: cpfController,
                  textInputType: TextInputType.number,
                  formatter: new MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r"[0-9]")}),
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
                    return CustomPassTextField(
                      formatter: new MaskTextInputFormatter(mask: "###############################################", filter: {"#": RegExp(r"[a-zA-Z0-9@. ]")}),
                      hint: "Senha",
                      onChanged: (value) {
                        loginStore.setPass(value);
                      },
                      controller: passController,
                      enabled: true,
                      obscure: loginStore.passVisible,
                      suffix: IconButton(
                        iconSize: 32,
                        icon: Icon(loginStore.passVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: loginStore.turnVisible,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Switch(
                          activeColor: Color.fromARGB(255, 108, 190, 193),
                          value: loginStore.remember,
                          onChanged: (value) {
                            setState(() {
                              loginStore.remember = value;
                            });
                          },
                        ),
                        Text(
                          "Lembrar senha",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.032),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return PassRecover1();
                        }));
                      },
                      child: Text(
                        "Recuperar senha",
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: MediaQuery.of(context).size.width * 0.032),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Observer(
                  builder: (_) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RaisedButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
                            Text(
                              "Entrar",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.exit_to_app)
                          ]),
                          color: loginStore.isFormValid ? Color.fromARGB(255, 137, 202, 204) : Colors.grey,
                          textColor: Colors.white,
                          onPressed: () async {
                            try {
                              await formAction();
                            } catch (e) {
                              var logger = new Logger();
                              logger.firebaseLog(e, data: {"tela": "login"});
                            }
                          }),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Cadastre-se",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 137, 202, 204))),
                    color: Color.fromARGB(255, 255, 255, 255),
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cadastro2()));
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                )
              ]);
  }

  formAction() async {
    {
      setState(() {
        loading = true;
      });
      var document = FirebaseFirestore.instance.collection("Drivers").doc(cpfController.text.replaceAll(".", "").replaceAll("-", ""));
      document.get().then((DocumentSnapshot doc) async {
        if (doc.exists) {
          if (doc["password"] == sha256.convert(utf8.encode(passController.text)).toString()) {
            baseStore.nome = capitalize(doc["name"].split(" ")[0] + " " + capitalize(doc["name"].split(" ")[1]));
            baseStore.cpf = doc.id;
            baseStore.telefone = doc["phone"];
            baseStore.vencimentoCNH = doc.get("cnhDueDate")!=null ? doc["cnhDueDate"] : "";
            baseStore.email = doc.get("email")!=null ? doc["email"] : "";
            baseStore.cnpj = doc["cnpj"].replaceAll(".", "").replaceAll(" ", "").replaceAll("/", "").replaceAll("-", "");
            var documentEmpresa = FirebaseFirestore.instance.collection("Companies").doc(baseStore.cnpj);
            documentEmpresa.get().then((DocumentSnapshot doc) async {
              baseStore.nomeEmpresa = doc["name"];
            });
            if (loginStore.remember) {
              loginStore.rememberCredentials();
            }
            if (doc["companyApproval"]) {
              var warningCount = await FirebaseFirestore.instance
                  .collection("Companies")
                  .doc(baseStore.cnpj.toString())
                  .collection("Warnings")
                  .where("type", whereIn: warnings)
                  .where("checked", isEqualTo: false)
                  .where("driverCPF", isEqualTo: baseStore.cpf)
                  .orderBy("date", descending: true)
                  .get();
              baseStore.warnings = warningCount.size;

              Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro1()));
            } else {
              baseStore.showMyDialog(context, "A empresa deve aprovar seu cadastro. Entrar em contato com o seu gestor.");
            }
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Erro"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text("Credenciais inválidas"),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        } else {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Alerta",
                  textScaleFactor: 1,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        "Motorista não cadastrado",
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      textScaleFactor: 1,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
      setState(() {
        loading = false;
      });
    }
  }
}
