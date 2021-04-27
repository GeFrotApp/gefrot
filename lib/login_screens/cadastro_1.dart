import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomobx/app_screens/base.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

class Cadastro1 extends StatefulWidget {
  @override
  _Cadastro1State createState() => _Cadastro1State();
}

class _Cadastro1State extends State<Cadastro1> {
  Cadastro1Store cadastro1Store;
  BaseStore baseStore;
  var loading = false;
  TextEditingController cavalo = new TextEditingController();
  TextEditingController carreta1 = new TextEditingController();
  TextEditingController carreta2 = new TextEditingController();
  TextEditingController carreta3 = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro1Store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);
    cavalo.text = cadastro1Store.placaCavalo;
    carreta1.text = cadastro1Store.placaCarreta1;
    carreta2.text = cadastro1Store.placaCarreta2;
    carreta3.text = cadastro1Store.placaCarreta3;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return CustomBackground(header: "Equipamentos", image: "img4.jpeg", children: loading
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
            :[
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
              "Veículo da jornada",
              textScaleFactor: 1,
              style: TextStyle(
                  color: Color.fromARGB(255, 137, 202, 204),
                  fontSize: MediaQuery.of(context).size.width * 0.073,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placa do veículo *",textScaleFactor: 1,
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextField(
              controller: cavalo,
              hint: 'Digite a placa',
              formatter: new MaskTextInputFormatter(mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
              onChanged: cadastro1Store.setPlacaCavalo,
              enabled: true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placa do equipamento",textScaleFactor: 1,
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          CustomTextField(
            controller: carreta1,
            hint: 'Digite a placa',
            formatter: new MaskTextInputFormatter(mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
            onChanged: cadastro1Store.setPlacaCarreta1,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          cadastro1Store.numCarretas > 1
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Placa do equipamento",textScaleFactor: 1,
                        style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
                      ),
                    ),
                    CustomTextField(
                      controller: carreta2,
                      hint: 'Digite a placa',
                      formatter: new MaskTextInputFormatter(mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
                      onChanged: cadastro1Store.setPlacaCarreta2,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : Container(),
          cadastro1Store.numCarretas > 2
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Placa do equipamento",textScaleFactor: 1,
                        style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
                      ),
                    ),
                    CustomTextField(
                      controller: carreta3,
                      hint: 'Digite a placa',
                      formatter: new MaskTextInputFormatter(mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
                      onChanged: cadastro1Store.setPlacaCarreta3,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : Container(),
          GestureDetector(
            onTap: cadastro1Store.addCarreta,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Adicionar equipamento",textScaleFactor: 1,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 25, 153, 158),
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Icon(Icons.add_circle, color: Color.fromARGB(255, 25, 153, 158), size: MediaQuery.of(context).size.width * 0.05),
              ],
            )),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              Switch(
                activeColor: Color.fromARGB(255, 108, 190, 193),
                value: cadastro1Store.remember,
                onChanged: (value) {
                  cadastro1Store.turnRemember();
                },
              ),
              Text(
                "Lembrar deste equipamento",textScaleFactor: 1,
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
              )
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
                    disabledColor: Color.fromARGB(255, 210, 210, 210),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Text(
                        'Entrar',textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.056,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        size: MediaQuery.of(context).size.width * 0.056,
                        color: Colors.white,
                      )
                    ]),
                    color: Color.fromARGB(255, 137, 202, 204),
                    onPressed: cadastro1Store.isFormValid
                        ? () async {
                            setState((){
                              loading = true;
                            });
                            var isOnline;
                            try {
                              final result = await InternetAddress.lookup('example.com');
                              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                isOnline = true;
                              }
                            } on SocketException catch (_) {
                              isOnline = false;
                            }
                            if(isOnline){
                              var checklistItemStore = new ChecklistItemStore();
                              try {
                                await checklistItemStore.uploadOfflineChecklists(baseStore.cnpj);
                              } on SocketException catch (_) {
                                isOnline = false;
                              }

                            }
                            final firestore = FirebaseFirestore.instance;
                            var document = await firestore
                                .collection("Companies")
                                .doc(baseStore.cnpj)
                                .collection("Horses")
                                .doc(cadastro1Store.placaCavalo)
                                .get();
                            var cavaloExists = document.data()?.isNotEmpty;
                            var carreta1Exists = true;
                            var carreta2Exists = true;
                            var carreta3Exists = true;
                            if (cadastro1Store.placaCarreta1.length == 8) {
                              var x = await firestore
                                  .collection("Companies")
                                  .doc(baseStore.cnpj)
                                  .collection("Trailers")
                                  .doc(cadastro1Store.placaCarreta1)
                                  .get();
                              carreta1Exists = x.data()?.isNotEmpty;
                            }
                            if (cadastro1Store.placaCarreta2.length == 8) {
                              var x = await firestore
                                  .collection("Companies")
                                  .doc(baseStore.cnpj)
                                  .collection("Trailers")
                                  .doc(cadastro1Store.placaCarreta2)
                                  .get();
                              carreta2Exists = x.data()?.isNotEmpty;
                            }
                            if (cadastro1Store.placaCarreta3.length == 8) {
                              var x = await firestore
                                  .collection("Companies")
                                  .doc(baseStore.cnpj)
                                  .collection("Trailers")
                                  .doc(cadastro1Store.placaCarreta2)
                                  .get();
                              carreta3Exists = x.data()?.isNotEmpty;
                            }
                            print(cavaloExists);
                            if (cavaloExists != null &&
                                carreta1Exists != null &&
                                carreta2Exists != null &&
                                carreta3Exists != null) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if (cadastro1Store.remember) {
                                prefs.setString("cavalo", cadastro1Store.placaCavalo);
                                prefs.setString("carreta1", cadastro1Store.placaCarreta1);
                                prefs.setString("carreta2", cadastro1Store.placaCarreta2);
                                prefs.setString("carreta3", cadastro1Store.placaCarreta3);
                              } else {
                                prefs.setString("cavalo", "");
                                prefs.setString("carreta1", "");
                                prefs.setString("carreta2", "");
                                prefs.setString("carreta3", "");
                              }
                              baseStore.odometro = document.data()['odometer'].toDouble();
                              baseStore.mediaProposta = document.data()['average'].toDouble();
                              print(baseStore.odometro.toString());
                              var now = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Base()));
                              firestore.collection('Drivers').doc(baseStore.cpf.replaceAll('.', "").replaceAll("-", "")).update({
                                'lastHorseChange': now,
                                'horse': cadastro1Store.placaCavalo,
                                'trailers': [
                                  cadastro1Store.placaCarreta1,
                                  cadastro1Store.placaCarreta2,
                                  cadastro1Store.placaCarreta3
                                ]
                              });
                              var motoristaComCavalo = await FirebaseFirestore.instance
                                  .collection('Drivers')
                                  .where("horse", isEqualTo: cadastro1Store.placaCavalo)
                                  .get();
                              if (motoristaComCavalo.docs.length > 1){
                                print(motoristaComCavalo.docs.first.data());
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Alerta',textScaleFactor: 1,),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text("Já existe um motorista com esse equipamento. Deseja prosseguir?",textScaleFactor: 1,),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Sim',textScaleFactor: 1,),
                                          onPressed: () {
                                            motoristaComCavalo.docs.forEach((doc) {
                                              if(doc.id!=baseStore.cpf){
                                                doc.reference.update({
                                                  "horse":"",
                                                  "trailers":[]
                                                });
                                              }

                                            });
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Base()));
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Não',textScaleFactor: 1,),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }else{
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Base()));
                                print(cadastro1Store.placaCarreta2);
                              }

                            } else if (cavaloExists == null) {
                              baseStore.showMyDialog(context, "O veículo não está cadastrado");
                            } else if (carreta1Exists == null) {
                              baseStore.showMyDialog(context, "A carreta 1 não está cadastrada");
                            } else if (carreta2Exists == null) {
                              baseStore.showMyDialog(context, "A carreta 2 não está cadastrada");
                            }
                            setState((){
                              loading = false;
                            });
                          }
                        : null),
              );
            },
          ),
        ]);
      },
    );
  }
}
