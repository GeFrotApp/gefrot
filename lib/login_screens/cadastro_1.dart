import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomobx/app_screens/base.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'cadastro_2.dart';

class Cadastro1 extends StatefulWidget {
  @override
  _Cadastro1State createState() => _Cadastro1State();
}

class _Cadastro1State extends State<Cadastro1> {
  Cadastro1Store cadastro1Store;
  BaseStore baseStore;
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
        return CustomBackground(header: "Equipamentos", image: "img4.jpeg", children: [
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
                    color: Color.fromARGB(255, 170, 170, 170),
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
              "Placa do cavalo *",
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
              "Placa da carreta",
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
                        "Placa da carreta",
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
                        "Placa da carreta",
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
                  "Adicionar carreta",
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
                "Lembrar deste equipamento",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Observer(
            builder: (_) {
              return SizedBox(
                height: 44,
                width: MediaQuery.of(context).size.width * 0.35,
                child: RaisedButton(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(children: <Widget>[
                      Text(
                        'Entrar',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.061),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        size: MediaQuery.of(context).size.width * 0.083,
                      )
                    ]),
                    color: cadastro1Store.isFormValid ? Color.fromARGB(255, 137, 202, 204) : Colors.grey,
                    textColor: Colors.white,
                    onPressed: cadastro1Store.isFormValid
                        ? () async {
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Base()));
                              firestore.collection('Drivers').doc(baseStore.cpf.replaceAll('.', "").replaceAll("-", "")).update({
                                'horse': cadastro1Store.placaCavalo,
                                'trailers': [
                                  cadastro1Store.placaCarreta1,
                                  cadastro1Store.placaCarreta2,
                                  cadastro1Store.placaCarreta3
                                ]
                              });
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Base()));
                              print(cadastro1Store.placaCarreta2);
                            } else if (cavaloExists == null) {
                              baseStore.showMyDialog(context, "O cavalo não está cadastrado");
                            } else if (carreta1Exists == null) {
                              baseStore.showMyDialog(context, "A carreta 1 não está cadastrada");
                            } else if (carreta2Exists == null) {
                              baseStore.showMyDialog(context, "A carreta 2 não está cadastrada");
                            }
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
