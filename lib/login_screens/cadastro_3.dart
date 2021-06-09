import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/cadastro_2_store.dart';
import 'package:todomobx/stores/cadastro_3_store.dart';
import 'package:todomobx/widgets/aviso.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'login_screen.dart';

class Cadastro3 extends StatefulWidget {
  @override
  _Cadastro3State createState() => _Cadastro3State();
}

class _Cadastro3State extends State<Cadastro3> {
  var remember = false;
  var loading = false;
  Cadastro3Store cadastro3Store;
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro3Store = Provider.of<Cadastro3Store>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(header: "Cadastro do motorista", children: [
      loading
          ? Center(
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
          : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: MediaQuery.of(context).size.width * 0.05,
                          color: Color.fromARGB(255, 120, 120, 120),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Vincule sua conta a uma transportadora *",
                    textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: MediaQuery.of(context).size.width * 0.061, color: Color.fromARGB(255, 137, 202, 204)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transportadora (CNPJ) *",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.048, color: Color.fromARGB(255, 11, 78, 78)),
                  ),
                ),
                CustomTextField(
                  hint: 'Digite o CNPJ',
                  textInputType: TextInputType.number,
                  formatter: new MaskTextInputFormatter(mask: 'XX. XXX. XXX/XXXX-XX', filter: {"X": RegExp(r'[0-9]')}),
                  onChanged: (value) async {
                    cadastro3Store.setCnpj(value);
                    if (cadastro3Store.cnpj.length == 20) {
                      final firestore = FirebaseFirestore.instance;
                      var x = await firestore
                          .collection('Companies')
                          .doc(
                              cadastro3Store.cnpj.replaceAll('.', "").replaceAll(" ", "").replaceAll("/", "").replaceAll("-", ""))
                          .get();
                      if (x.exists) {
                        cadastro3Store.setNomeEmpresa(x.data()['name']);
                      } else {
                        cadastro3Store.setNomeEmpresa("Empresa não cadastrada");
                      }
                    } else {
                      cadastro3Store.setNomeEmpresa("");
                    }
                  },
                  enabled: true,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Observer(
                      builder: (_) {
                        return cadastro3Store.nomeEmpresa == ""
                            ? Text("")
                            : Text(
                                cadastro3Store.nomeEmpresa,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: cadastro3Store.nomeEmpresa != "Empresa não cadastrada"
                                        ? Color.fromARGB(255, 137, 202, 204)
                                        : Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context).size.width * 0.045),
                                textAlign: TextAlign.left,
                              );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Observer(
                      builder: (context) {
                        return Checkbox(
                          value: cadastro3Store.check1,
                          onChanged: cadastro3Store.setCheck1,
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        baseStore.showTerms(context);
                      },
                      child: Text(
                        "Termos de uso",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Observer(
                  builder: (_) {
                    return SizedBox(
                      height: 44,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Cadastrar',
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.check)
                          ],
                        ),
                        color: cadastro3Store.isFormValid && cadastro3Store.nomeEmpresa != "Empresa não cadastrada"
                            ? Color.fromARGB(255, 137, 202, 204)
                            : Color.fromARGB(255, 210, 210, 210),
                        textColor: Colors.white,
                        onPressed: cadastro3Store.isFormValid && cadastro3Store.nomeEmpresa != "Empresa não cadastrada"
                            ? () async {
                                setState(() {
                                  loading = !loading;
                                });
                                var cadastro1Store = Provider.of<Cadastro1Store>(context, listen: false);
                                var cadastro2Store = Provider.of<Cadastro2Store>(context, listen: false);
                                final firestore = FirebaseFirestore.instance;
                                firestore
                                    .collection('Drivers')
                                    .doc(cadastro2Store.cpf.replaceAll('.', "").replaceAll("-", ""))
                                    .set({
                                  'name': cadastro2Store.nome.toLowerCase(),
                                  'password': sha256.convert(utf8.encode(cadastro2Store.pass)).toString(),
                                  'phone': cadastro2Store.telefone,
                                  'email': cadastro2Store.email,
                                  'cnpj': cadastro3Store.cnpj
                                      .replaceAll('.', "")
                                      .replaceAll(" ", "")
                                      .replaceAll("/", "")
                                      .replaceAll("-", ""),
                                  'cnhDueDate': cadastro2Store.dataCNH,
                                  'companyApproval': false,
                                  'ingressDate': Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
                                });
                                firestore.collection('Companies').doc(cadastro3Store.cnpj
                                    .replaceAll('.', "")
                                    .replaceAll(" ", "")
                                    .replaceAll("/", "")
                                    .replaceAll("-", "")).collection("Warnings").add({
                                  "checked": false,
                                  "date": Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
                                  "driverCPF": cadastro2Store.cpf.replaceAll('.', "").replaceAll("-", ""),
                                  "driverReference": "/Drivers/"+cadastro2Store.cpf.replaceAll('.', "").replaceAll("-", ""),
                                  "text": "O motorista, "+cadastro2Store.nome.toLowerCase()+" solicitou acesso.",
                                  "type": "newDriver"
                                });



                                setState(() {
                                  loading = !loading;
                                });
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                  return Aviso("Usuário cadastrado!");
                                }));
                                await Future.delayed(const Duration(seconds: 2), () => "2");
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                  return LoginScreen();
                                }));
                              }
                            : () {},
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
    ]);
  }
}
