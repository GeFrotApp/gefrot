import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/edicao.dart';
import 'package:todomobx/app_modules/abastecimento_module/historico.dart';
import 'package:todomobx/app_modules/abastecimento_module/registro.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/widgets/base_top.dart';

class AbastecimentoBase extends StatefulWidget {
  @override
  _AbastecimentoBaseState createState() => _AbastecimentoBaseState();
}

class _AbastecimentoBaseState extends State<AbastecimentoBase> {
  AbastecimentoBaseStore abastecimentoBaseStore;
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (abastecimentoBaseStore.index == 1) {
            bool confirm;
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Alerta'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text("As informações do registro serão perdidas. Tem certeza?"),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.06,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color.fromARGB(255, 255, 165, 165)),
                          child: Center(
                            child: Text(
                              "Não",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          confirm = false;
                        },
                      ),
                      FlatButton(
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.06,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color.fromARGB(255, 137, 202, 204)),
                          child: Center(
                            child: Text(
                              "Sim",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          abastecimentoBaseStore.index = 0;
                          confirm = true;
                        },
                      ),
                    ],
                  );
                });

            return confirm;
          } else {
            return true;
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              color: Color.fromARGB(255, 230, 230, 230),
              child: SafeArea(
                child: Column(
                  children: [
                    BaseTop(),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                              child: Center(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color.fromARGB(255, 120, 120, 120),
                                      size: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                    onPressed: () {
                                      abastecimentoBaseStore.index == 0
                                          ? Navigator.of(context).pop()
                                          : abastecimentoBaseStore.setIndex(0, context, true);
                                    }),
                              )),
                          Text(
                            "  Abastecimento  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Color.fromARGB(255, 100, 100, 100)),
                          ),
                          FaIcon(FontAwesomeIcons.gasPump,
                              size: MediaQuery.of(context).size.height * 0.035, color: Color.fromARGB(255, 230, 230, 59)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Observer(
                      builder: (_) {
                        return Expanded(
                            child: Container(
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                          width: MediaQuery.of(context).size.width * 0.98,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: abastecimentoBaseStore.index == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        elevation: 5,
                                        color: Colors.white,
                                        onPressed: () async {
                                          abastecimentoBaseStore.setIndex(1, context, true);
                                          try {
                                            final result = await InternetAddress.lookup('example.com');
                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                              baseStore.online = true;
                                              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                            }
                                          } on SocketException catch (_) {
                                            baseStore.online = false;
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Registrar",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            ),
                                            Text(
                                              "Abastecimento",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        elevation: 5,
                                        color: Colors.white,
                                        onPressed: () async {
                                          abastecimentoBaseStore.setIndex(2, context, true);
                                          try {
                                            final result = await InternetAddress.lookup('example.com');
                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                              baseStore.online = true;
                                              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                            }
                                          } on SocketException catch (_) {
                                            baseStore.online = false;
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Histórico de",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            ),
                                            Text(
                                              "Abastecimentos",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : abastecimentoBaseStore.index == 1
                                  ? Registro()
                                  : abastecimentoBaseStore.index == 2
                                      ? Container(
                                          child: Historico(),
                                        )
                                      : Documento(),
                        ));
                      },
                    )
                  ],
                ),
              ),
            )) // Your Scaffold goes here.
        );
  }
}
